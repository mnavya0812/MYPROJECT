#ifndef PHONESCREEN_H
#define PHONESCREEN_H

#include <QObject>
#include <QQmlComponent>
#include <QQuickItem>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <MainMenu.h>

class MainMenu;

class PhoneScreen : public QObject
{
    Q_OBJECT

public:
    explicit PhoneScreen(QObject *parent = nullptr);
    void display();
    void setEngine(QQmlApplicationEngine* engine);

public slots:
    void onRefresh(QVariant value);
    void onHome();
    void displayNext();

private:
    QQmlApplicationEngine* m_engine;
    QQuickWindow* m_window;
    QQuickItem* PhoneScreenRootItem;
    MainMenu* mainMenu;
    QQuickItem* dial;
    QQuickItem* contacts;
    QQuickItem* homeButton;
};

#endif // PHONESCREEN_H
