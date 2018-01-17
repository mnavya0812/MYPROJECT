#include "RadioScreen.h"
#include <iostream>
using namespace std;

RadioScreen::RadioScreen(QObject *parent) : QObject(parent)
{

}

void RadioScreen::display()
{
    QQmlComponent* radioComponent = new QQmlComponent(m_engine, QUrl("qrc:/Radio.qml"));
    QQuickItem* radioScreenRootItem = qobject_cast<QQuickItem*>(radioComponent->create());
    radioScreenRootItem->setParentItem(m_window->contentItem());

    browse = radioScreenRootItem->findChild<QQuickItem*>("browse");
    if(browse!=nullptr)
    {
        cout<<"browse button from radio found\n";
    }
    else
    {
        cout<<"browse button not found\n";
    }

    homeButton = radioScreenRootItem->findChild<QQuickItem*>("home");

    displayNext();
}

void RadioScreen::setEngine(QQmlApplicationEngine *engine)
{
    m_engine=engine;
    QObject* object=engine->rootObjects().at(0);
    m_window=qobject_cast<QQuickWindow*>(object);
}

void RadioScreen::displayNext()
{
    if (browse != nullptr)
    {   cout<<"browse button from radio found\n";
        QObject::connect(browse, SIGNAL (refresh(QVariant)), this, SLOT(onRefresh(QVariant)));
    }
    else
    {
        cout<<"browse button not found\n";
    }

    if(homeButton != nullptr)
    {
        cout<< "home button from radioScreen found\n";
        QObject::connect(homeButton, SIGNAL(refresh(QVariant)), this, SLOT(onRefresh(QVariant)));
    }
    else
    {
        cout<<"home button not found\n";
    }
}

void RadioScreen::onRefresh(QVariant value)
{
    if(value == "browse")
    {
        QQmlComponent* BrowseScreenComponent = new QQmlComponent(m_engine,QUrl("qrc:/Stations.qml"));
        QQuickItem* BrowseScreenRootItem = qobject_cast<QQuickItem*>(BrowseScreenComponent->create());
        BrowseScreenRootItem->setParentItem(m_window->contentItem());

        homeButton = BrowseScreenRootItem->findChild<QQuickItem*>("home");
        QObject::connect(homeButton, SIGNAL(refresh(QVariant)), this, SLOT(onRefresh(QVariant)));
    }

    if(value== "home")
    {
        cout<<"inside home button\n";
        mainMenu = new MainMenu();
        mainMenu->setEngine(m_engine);
        mainMenu->display();
    }
}

void RadioScreen::onHome()
{
    display();
}
