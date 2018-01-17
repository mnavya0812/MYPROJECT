#include "MediaScreen.h"
#include <iostream>
using namespace std;

MediaScreen::MediaScreen(QObject *parent) : QObject(parent)
{

}

void MediaScreen::display()
{
    QQmlComponent* mediaComponent = new QQmlComponent(m_engine, QUrl("qrc:/Media.qml"));
    QQuickItem* mediaScreenRootItem = qobject_cast<QQuickItem*>(mediaComponent->create());
    mediaScreenRootItem->setParentItem(m_window->contentItem());

    homeButton = mediaScreenRootItem->findChild<QQuickItem*>("home");

    displayNext();
}

void MediaScreen::setEngine(QQmlApplicationEngine *engine)
{
    m_engine=engine;
    QObject* object=engine->rootObjects().at(0);
    m_window=qobject_cast<QQuickWindow*>(object);
}

void MediaScreen::displayNext()
{
    if(homeButton != nullptr)
    {
        cout<< "home button from mediaScreen found\n";
        QObject::connect(homeButton, SIGNAL(refresh(QVariant)), this, SLOT(onRefresh(QVariant)));
    }
    else
    {
        cout<<"home button not found\n";
    }
}

void MediaScreen::onRefresh(QVariant value)
{
    if(value== "home")
    {
        cout<<"inside home button\n";
        mainMenu = new MainMenu();
        mainMenu->setEngine(m_engine);
        mainMenu->display();
    }
}
void MediaScreen::onHome()
{
    display();
}
