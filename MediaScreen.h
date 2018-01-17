#ifndef MEDIASCREEN_H
#define MEDIASCREEN_H

#include <QObject>
#include <QQmlComponent>
#include <QQuickItem>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <MainMenu.h>

class MainMenu;

class MediaScreen : public QObject
{
    Q_OBJECT

public:
    explicit MediaScreen(QObject *parent = nullptr);
    void display();
    void setEngine(QQmlApplicationEngine* engine);

public slots:
    void onRefresh(QVariant value);
    void onHome();
    void displayNext();

private:
    QQmlApplicationEngine* m_engine;
    QQuickWindow* m_window;
    QQuickItem* MediaScreenRootItem;
    MainMenu* mainMenu;
    QQuickItem* homeButton;
};

#endif // MEDIASCREEN_H


