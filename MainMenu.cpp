#include "MainMenu.h"
#include <QQmlComponent>
#include <QQuickItem>

MainMenu::MainMenu(QObject *parent) : QObject(parent)
{
    radioScreen = new RadioScreen();
    mediaScreen = new MediaScreen();
    phoneScreen = new PhoneScreen();
    naviScreen = new NaviScreen();
    settingsScreen = new SettingsScreen();
}

void MainMenu::display()
{
    QQmlComponent* firstQmlComponent = new QQmlComponent(m_engine, QUrl("qrc:/MainScreen.qml"));
    QQuickItem* firstScreenRootItem = qobject_cast<QQuickItem*>(firstQmlComponent->create());
    firstScreenRootItem->setParentItem(m_window->contentItem());

    Gridview gridItems;
    gridItems.gridMembers();

    QQuickItem* gridviewptr = firstScreenRootItem->findChild<QQuickItem*>("gridview");
    gridviewptr->setProperty("model", QVariant::fromValue(&gridItems));
    if(gridviewptr!=nullptr)
    {
        QObject::connect(gridviewptr, SIGNAL(released(int)), this, SLOT(onReleased(int)));

    }

    radioScreen->setEngine(m_engine);
    mediaScreen->setEngine(m_engine);
    phoneScreen->setEngine(m_engine);
    naviScreen->setEngine(m_engine);
    settingsScreen->setEngine(m_engine);
}

void MainMenu::setEngine(QQmlApplicationEngine *engine)
{
    m_engine=engine;
    QObject* object=engine->rootObjects().at(0);
    m_window=qobject_cast<QQuickWindow*>(object);

}

void MainMenu::onReleased(int index)
{
    switch(index)
    {
    case 0:
        radioScreen->display();
        break;
    case 1:
        mediaScreen->display();
        break;
    case 2:
        phoneScreen->display();
        break;
    case 3:
        naviScreen->display();
        break;
    case 4:
        settingsScreen->display();
        break;
    default:
        break;
    }
}
