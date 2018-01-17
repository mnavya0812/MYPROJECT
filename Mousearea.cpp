#include "Mousearea.h"
#include <iostream>

using namespace std;

Mousearea::Mousearea(QObject *parent) : QObject(parent)
{
    mScreen1RootItem = nullptr;
}

void Mousearea::onPressed()
{
    QQuickItem* rectangle = mScreen1RootItem->findChild<QQuickItem*>("gridview");
    rectangle->setProperty("cellHeight", 260);
    rectangle->setProperty("cellWidth", 256);
}

void Mousearea::onReleased()
{
    cout << "onReleased received onto CPP side" << endl;
    QQuickItem* rectangle = mScreen1RootItem->findChild<QQuickItem*>("gridview");

    rectangle->setProperty("cellHeight", 260);
    rectangle->setProperty("cellWidth", 260);
}

void Mousearea::onEntered()
{
    //    QQuickItem* rectangle = mScreen1RootItem->findChild<QQuickItem*>("FirstScreenRectangle");
    //    rectangle->setProperty();
}

void Mousearea::onExited()
{
    //    QQuickItem* rectangle = mScreen1RootItem->findChild<QQuickItem*>("FirstScreenRectangle");
    //    rectangle->setProperty();
}

void Mousearea::setScreen1(QQuickItem *rootItem)
{
    mScreen1RootItem = rootItem;
}
