#include <QGuiApplication>
#include <QCoreApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QQuickView>
#include <QQmlContext>
#include <QQuickItem>
#include <QAbstractItemModel>
#include <Gridview.h>
#include <iostream>
#include <Mousearea.h>
#include <MainMenu.h>

using namespace std;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl (QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    MainMenu mainMenu;
    mainMenu.setEngine(&engine);
    mainMenu.display();

    return app.exec();
}
