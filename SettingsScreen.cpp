#include "SettingsScreen.h"
#include <iostream>
#include <ListView.h>

using namespace std;

SettingsScreen::SettingsScreen(QObject *parent) : QObject(parent)
{

}

void SettingsScreen::display()
{
    QQmlComponent* settingsComponent = new QQmlComponent(m_engine, QUrl("qrc:/Settings.qml"));
    QQuickItem* settingsScreenRootItem = qobject_cast<QQuickItem*>(settingsComponent->create());
    settingsScreenRootItem->setParentItem(m_window->contentItem());

    ListView listViews;
    listViews.listMembers();

    QQuickItem* settings = settingsScreenRootItem->findChild<QQuickItem*>("settingsListView");
    settings->setProperty("model", QVariant::fromValue(&listViews));

    QQuickItem* homeButton = settingsScreenRootItem->findChild<QQuickItem*>("home");
    if(homeButton != nullptr)
    {
        cout<< "home button from settingsScreen found\n";
        QObject::connect(homeButton, SIGNAL(refresh(QVariant)), this, SLOT(onRefresh(QVariant)));
    }
    else
    {
        cout<<"home button not found\n";
    }

    if(settings!=nullptr)
    {
        QObject::connect(settings, SIGNAL(released(int)), this, SLOT(onReleased(int)));
    }
}

void SettingsScreen::setEngine(QQmlApplicationEngine *engine)
{
    m_engine=engine;
    QObject* object=engine->rootObjects().at(0);
    m_window=qobject_cast<QQuickWindow*>(object);
}

void SettingsScreen::onRefresh(QVariant value)
{
    if(value== "home")
    {
        cout<<"inside home button settings\n";
        mainMenu = new MainMenu();
        mainMenu->setEngine(m_engine);
        mainMenu->display();
    }
}

void SettingsScreen::onHome()
{
    display();
}

void SettingsScreen::onReleased(int index)
{
    cout<<"inside release"<< index<<endl;
    switch(index)
    {
    case 0:
        screenUrl = "qrc:/RadioSettings.qml" ;
        break;
    case 1:
        screenUrl = "qrc:/MediaSettings.qml" ;
        break;
    case 2:
        screenUrl = "qrc:/RadioSettings.qml" ;
        break;
    case 3:
        screenUrl = "qrc:/MediaSettings.qml";
        break;
    default:
        break;
    }

    QQmlComponent* NextSettingsScreenComponent = new QQmlComponent(m_engine,QUrl(screenUrl));
    QQuickItem* NextSettingsScreenRootItem = qobject_cast <QQuickItem*> (NextSettingsScreenComponent->create());
    NextSettingsScreenRootItem->setParentItem(m_window->contentItem());

    QQuickItem* homeButton = NextSettingsScreenRootItem->findChild<QQuickItem*>("home");
    if(homeButton != nullptr)
    {
        cout<< "home button from phonesettingsScreen found\n";
        QObject::connect(homeButton, SIGNAL(refresh(QVariant)), this, SLOT(onRefresh(QVariant)));
    }
    else
    {
        cout<<"home button not found\n";
    }
}
