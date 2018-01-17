#ifndef RADIOSCREEN_H
#define RADIOSCREEN_H

#include <QObject>
#include <QQmlComponent>
#include <QQuickItem>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <MainMenu.h>

class MainMenu;

class RadioScreen : public QObject
{
    Q_OBJECT

public:
    explicit RadioScreen(QObject *parent = nullptr);
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

#endif // RADIOSCREEN_H
