#include "PhoneScreen.h"
#include <iostream>
using namespace std;

PhoneScreen::PhoneScreen(QObject *parent) : QObject(parent)
{

}

void PhoneScreen::display()
{
    QQmlComponent* phoneComponent = new QQmlComponent(m_engine, QUrl("qrc:/Phone.qml"));
    QQuickItem* phoneScreenRootItem = qobject_cast<QQuickItem*>(phoneComponent->create());
    phoneScreenRootItem->setParentItem(m_window->contentItem());

    dial = phoneScreenRootItem->findChild<QQuickItem*>("dial");
    if(dial!=nullptr)
    {
        cout<<"dial button from phone found\n";
    }

    contacts = phoneScreenRootItem->findChild<QQuickItem*>("contacts");
    homeButton = phoneScreenRootItem->findChild<QQuickItem*>("home");

    displayNext();
}

void PhoneScreen::setEngine(QQmlApplicationEngine *engine)
{
    m_engine=engine;
    QObject* object=engine->rootObjects().at(0);
    m_window=qobject_cast<QQuickWindow*>(object);
}

void PhoneScreen::displayNext()
{
    if (dial != nullptr)
    {   cout<<"dial button from phone found\n";
        QObject::connect(dial, SIGNAL (refresh(QVariant)), this, SLOT(onRefresh(QVariant)));
    }
    else
    {
        cout<<"dial button not found\n";
    }

    if (contacts != nullptr)
    {
        cout << "contacts refresh found"<<endl;
        QObject::connect(contacts, SIGNAL(refresh(QVariant)), this, SLOT(onRefresh(QVariant)));
    }
    else
    {
        cout<<"contacts button not found\n";
    }

    if(homeButton != nullptr)
    {
        cout<< "home button from phoneScreen found\n";
        QObject::connect(homeButton, SIGNAL(refresh(QVariant)), this, SLOT(onRefresh(QVariant)));
    }
    else
    {
        cout<<"home button not found\n";
    }
}

void PhoneScreen::onRefresh(QVariant value)
{
    if(value == "dial")
    {
        QQmlComponent* DialScreenComponent = new QQmlComponent(m_engine,QUrl("qrc:/Keypad.qml"));
        QQuickItem* DialScreenRootItem = qobject_cast<QQuickItem*>(DialScreenComponent->create());
        DialScreenRootItem->setParentItem(m_window->contentItem());

        QQuickItem* reverse = DialScreenRootItem->findChild<QQuickItem*>("phoneicon");
        QObject::connect(reverse, SIGNAL(reverse()), this, SLOT(onHome()));

        homeButton = DialScreenRootItem->findChild<QQuickItem*>("home");
        QObject::connect(homeButton, SIGNAL(refresh(QVariant)), this, SLOT(onRefresh(QVariant)));
    }

    if(value=="contacts")
    {
        cout<<"refresh"<<endl;
        QQmlComponent* ContactsScreenComponent = new QQmlComponent(m_engine,QUrl("qrc:/Contacts.qml"));
        QQuickItem* ContactsScreenRootItem = qobject_cast <QQuickItem*> (ContactsScreenComponent->create());
        ContactsScreenRootItem->setParentItem(m_window->contentItem());

        homeButton = ContactsScreenRootItem->findChild<QQuickItem*>("home");
        QObject::connect(homeButton, SIGNAL(refresh(QVariant)), this, SLOT(onRefresh(QVariant)));
    }
    else
    {
        cout<<"contacts not found"<<endl;
    }

    if(value== "home")
    {
        cout<<"inside home button\n";
        mainMenu = new MainMenu();
        mainMenu->setEngine(m_engine);
        mainMenu->display();
    }
}

void PhoneScreen::onHome()
{
    display();
}
