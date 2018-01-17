#ifndef NAVISCREEN_H
#define NAVISCREEN_H

#include <QObject>
#include <QQmlComponent>
#include <QQuickItem>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <MainMenu.h>

class MainMenu;

class NaviScreen : public QObject
{
    Q_OBJECT

public:
    explicit NaviScreen(QObject *parent = nullptr);
    void display();
    void setEngine(QQmlApplicationEngine* engine);

public slots:
    void onRefresh(QVariant value);
    void onHome();
    void displayNext();

private:
    QQmlApplicationEngine* m_engine;
    QQuickWindow* m_window;
    QQuickItem* RadioScreenRootItem;
    MainMenu* mainMenu;
    QQuickItem* browse;
    QQuickItem* homeButton;
};

#endif // NAVISCREEN_H
