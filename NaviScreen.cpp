#include "NaviScreen.h"
#include <iostream>

using namespace std;

NaviScreen::NaviScreen(QObject *parent) : QObject(parent)
{

}

void NaviScreen::display()
{
    QQmlComponent* naviComponent = new QQmlComponent(m_engine, QUrl("qrc:/Navi.qml"));
    QQuickItem* naviScreenRootItem = qobject_cast<QQuickItem*>(naviComponent->create());
    naviScreenRootItem->setParentItem(m_window->contentItem());

    homeButton = naviScreenRootItem->findChild<QQuickItem*>("home");

    displayNext();
}

void NaviScreen::setEngine(QQmlApplicationEngine *engine)
{
    m_engine=engine;
    QObject* object=engine->rootObjects().at(0);
    m_window=qobject_cast<QQuickWindow*>(object);
}

void NaviScreen::displayNext()
{
    if(homeButton != nullptr)
    {
        cout<< "home button from naviScreen found\n";
        QObject::connect(homeButton, SIGNAL(refresh(QVariant)), this, SLOT(onRefresh(QVariant)));
    }
    else
    {
        cout<<"home button not found\n";

    }
}

void NaviScreen::onRefresh(QVariant value)
{
    if(value== "home")
    {
        cout<<"inside home button\n";
        mainMenu = new MainMenu();
        mainMenu->setEngine(m_engine);
        mainMenu->display();
    }
}

void NaviScreen::onHome()
{
    display();
}
