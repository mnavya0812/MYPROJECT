package com.adidas.dam.updatenotification;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Dictionary;
import java.util.HashMap;
import java.util.Map;

import javax.jcr.Node;
import javax.jcr.NodeIterator;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.jcr.query.Query;
import javax.jcr.query.QueryManager;
import javax.jcr.query.QueryResult;
import javax.mail.internet.InternetAddress;

import org.apache.commons.lang.text.StrLookup;
import org.apache.commons.mail.HtmlEmail;
import org.apache.felix.scr.annotations.Activate;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.PropertyUnbounded;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.sling.api.resource.LoginException;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.sling.api.resource.ResourceResolverFactory;
import org.apache.sling.commons.json.JSONArray;
import org.apache.sling.commons.json.JSONException;
import org.apache.sling.commons.json.JSONObject;
import org.apache.sling.commons.osgi.PropertiesUtil;
import org.osgi.service.component.ComponentContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.adidas.dam.services.AssetUpdateNotificationService;
import com.adidas.dam.util.PublisherHttpClientFactory;
import com.day.cq.commons.mail.MailTemplate;
import com.day.cq.mailer.MessageGateway;
import com.day.cq.mailer.MessageGatewayService;

@Component(immediate=true, metatype=true)
@Service
@Properties({
	@Property(name = "publisher.urls", unbounded = PropertyUnbounded.ARRAY, label="Publisher URLs", description="URLs for the publish instances, starting with http://"),
	@Property(name = "endpoint.url", unbounded = PropertyUnbounded.DEFAULT, label = "Endpoint host", description = "Dispatcher or other host:port value where the asset detail page is stored. This will prefix the asset path in the email."),
	@Property(name = "publisher.credentials", unbounded = PropertyUnbounded.DEFAULT, label = "Publisher Credentials", description = "Username and password separated by :"),
	@Property(name = "asset.detail.path", unbounded = PropertyUnbounded.DEFAULT, label = "Asset Detail Path", description = "Path to the asset detail page on the endpoint host."),
	@Property(name = "login.page", unbounded = PropertyUnbounded.DEFAULT, label = "Login Page Path", description = "Path to the login page.")
})
public class AssetUpdateNotificationServiceImpl implements AssetUpdateNotificationService {

	private static final String ASSET_UPDATE_TEMPLATE = "/etc/notification/AssetUpdateNotificationTemplate.txt";
	private static final Logger log = LoggerFactory.getLogger(AssetUpdateNotificationServiceImpl.class);
	
	private PublisherHttpClientFactory clientFactory;

	@Reference
	ResourceResolverFactory resolverFactory;

	@Reference
	MessageGatewayService messageGatewayService;

	private String[] publishUrls;
	private String endpointUrl;
	private String publishCredentials;
	private String assetDetailPath;
	private String loginPage;

	public void notifyUsers() {
		try {
			ResourceResolver resolver = resolverFactory.getAdministrativeResourceResolver(null);
			Session session = resolver.adaptTo(Session.class);
			QueryManager queryManager = session.getWorkspace().getQueryManager();

			HashMap<String, ArrayList<String>> emailDownloads = new HashMap<String, ArrayList<String>>();

			Calendar today = Calendar.getInstance();
			Calendar yesterday = Calendar.getInstance();
			yesterday.add(Calendar.DAY_OF_MONTH, -1);
			SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd'T00:00:00.000Z'");

			String sql = "SELECT * FROM [dam:Asset] WHERE ISDESCENDANTNODE([/content/dam]) "
					+ "AND [jcr:content/cq:lastReplicationAction] LIKE 'Activate' "
					+ "AND [jcr:content/cq:lastReplicated] > CAST('" + sdf.format(yesterday.getTime()) + "' AS DATE) "
					+ "AND [jcr:content/cq:lastReplicated] < CAST('" + sdf.format(today.getTime()) + "' AS DATE) ";

			log.debug("SQL: " + sql);

			Query query = queryManager.createQuery(sql, Query.JCR_SQL2);
			QueryResult result = query.execute();

			NodeIterator nodes = result.getNodes();
			log.debug(nodes.getSize() + " assets have been gathered for notifications.");

			while (nodes.hasNext()) {
				Node resultNode = nodes.nextNode();
				String assetPath = resultNode.getPath();

				ArrayList<String> emailsForDownload = getEmails(assetPath);

				log.info("Sending notifications for " + assetPath);
				for (String email : emailsForDownload) {
					ArrayList<String> downloads;
					if (emailDownloads.containsKey(email)) {
						downloads = emailDownloads.get(email);
					} else {
						downloads = new ArrayList<String>();
					}

					if (!downloads.contains(assetPath)) {
						log.debug("Downloader: " + email);
						downloads.add(assetPath);
					}

					emailDownloads.put(email, downloads);
				}

			}

			// Get email template
			// Getting the Email template.
			Resource templateResource = resolver.getResource(ASSET_UPDATE_TEMPLATE);

			if (templateResource != null) {

				if (templateResource.getChild("file") != null) {
					templateResource = templateResource.getChild("file");
				}

				MailTemplate mailTemplate = MailTemplate.create(templateResource.getPath(), session);

				for (Map.Entry<String, ArrayList<String>> emailDownload : emailDownloads.entrySet()) {
					log.info("Sending notification to " + emailDownload.getKey());
					sendEmailNotification(emailDownload.getKey(), emailDownload.getValue(), mailTemplate, session);
				}
			} else {
				log.error("Missing template: " + ASSET_UPDATE_TEMPLATE);
			}

		} catch (LoginException e) {
			log.error("Error in notifyUsers", e);
		} catch (RepositoryException e) {
			log.error("Error in notifyUsers", e);
		}
	}

	private void sendEmailNotification(String emailAddress, ArrayList<String> downloads, MailTemplate mailTemplate, Session session) {
		ArrayList<InternetAddress> emailRecipients = new ArrayList<InternetAddress>();
		String comments = "";
		StringBuilder assetLinks = new StringBuilder("");
		assetLinks.append("<ul>");
		for (String assetPath : downloads) {
			String assetName = assetPath.substring(assetPath.lastIndexOf("/") + 1);
			assetLinks.append("<li><a href='").append(this.endpointUrl).append(this.loginPage).append("?resource=")
			.append(assetPath).append(".form.html").append(this.assetDetailPath).append("'>")
			.append(assetName).append("</a></li>");
			
			if(assetPath!="")
			{
				Node commentsNode = session.getNode(assetPath+"/jcr:content/comments");
				if(commentsNode!=null)
				{
					NodeIterator nodeListItr = commentsNode.getNodes();
					while (nodeListItr.hasNext()) {
						Node node = nodeListItr.nextNode();
						comments = node.getProperty("jcr:description").getString();
						
					}				
			}
		}
		assetLinks.append("</ul>");

		Map<String, String> properties = new HashMap<String, String>();

		properties.put("assetLinks", assetLinks.toString());
		properties.put("comments", comments.toString());

		try {
			MessageGateway<HtmlEmail> messageGateway = messageGatewayService.getGateway(HtmlEmail.class);
			// Creating the Email.
			HtmlEmail email = new HtmlEmail();
			email.setCharset("UTF-8");

			// build the actual email content
			email = mailTemplate.getEmail(StrLookup.mapLookup(properties), HtmlEmail.class);

			emailRecipients.add(new InternetAddress(emailAddress));

			email.setTo(emailRecipients);
			email.setSubject(downloads.size() + " New Version(s) of Assets you recently ordered have been uploaded");

			messageGateway.send(email);

		} catch (Exception e) {
			log.error("Fatal error while sending email: ", e);
		}
	}

	private ArrayList<String> getEmails(String path) {
		ArrayList<String> emails = new ArrayList<String>();

		for (String publisher : publishUrls) {
			CloseableHttpClient httpClient = clientFactory.getPublisherHttpClient(publisher, publishCredentials);

			String getURL = publisher + "/bin/downloadLogs?asset=" + path;
			log.debug("GET " + getURL);
			HttpGet httpGet = new HttpGet(getURL.replace(" ", "%20"));

			CloseableHttpResponse response = null;
			try {
				response = httpClient.execute(httpGet);

				if (response.getStatusLine().getStatusCode() == 200) {
					InputStream responseStream = response.getEntity().getContent();

					BufferedReader br = new BufferedReader(new InputStreamReader(responseStream));

					String responseString = "";
					String line = "";
					while ((line = br.readLine()) != null) {
						responseString += line;
					}

					JSONObject responseObject = new JSONObject(responseString);

					JSONArray downloads = responseObject.getJSONArray("downloads");

					for (int i = 0; i < downloads.length(); i++) {
						JSONObject download = downloads.getJSONObject(i);
						if (download.has("email")) {
							String email = download.getString("email");

							if (!emails.contains(email)) {
								log.debug("Adding " + email + " for " + path);
								emails.add(email);
							}

						}
					}

				} else {
					log.error("Could not get JSON from publisher. " + response.getStatusLine().getStatusCode() + " " + response.getStatusLine().getReasonPhrase());
				}
			} catch (IOException e) {
				log.error("Cannot obtain download logs from " + getURL + ". " + e.getMessage());
			} catch (JSONException e) {
				log.error("Cannot parse JSON Object. " + e.getMessage());
			}
		}

		return emails;
	}

	public String[] getPublisherUrls() {
		return this.publishUrls;
	}

	public String getPublisherCredentials() {
		return this.publishCredentials;
	}
	
	@Activate
	protected void activate(ComponentContext componentContext) {
		log.debug("Activating AssetUpdateNotificationService.");
		final Dictionary<?, ?> props = componentContext.getProperties();

		this.publishUrls = PropertiesUtil.toStringArray(props.get("publisher.urls"), new String[]{"http://localhost:4503"});
		this.endpointUrl = PropertiesUtil.toString(props.get("endpoint.url"), "http://uscanamap290");
		this.publishCredentials = PropertiesUtil.toString(props.get("publisher.credentials"), "admin:admin");
		this.assetDetailPath = PropertiesUtil.toString(props.get("asset.detail.path"), "/content/sld/en/assets/details.html");
		this.loginPage = PropertiesUtil.toString(props.get("login.page"), "/content/sld/en/login.html");
		
		this.clientFactory = new PublisherHttpClientFactory();
	}
}
