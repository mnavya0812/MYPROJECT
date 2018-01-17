#ifndef SETTINGSSCREEN_H
#define SETTINGSSCREEN_H

#include <QObject>
#include <QQmlComponent>
#include <QQuickItem>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <MainMenu.h>

class MainMenu;

class SettingsScreen : public QObject
{
    Q_OBJECT

public:
    explicit SettingsScreen(QObject *parent = nullptr);
    void display();
    void setEngine(QQmlApplicationEngine* engine);

public slots:
    void onRefresh(QVariant value);
    void onHome();
    void onReleased(int index);

private:
    QQmlApplicationEngine* m_engine;
    QQuickWindow* m_window;
    QQuickItem* SettingsScreenRootItem;
    MainMenu* mainMenu;
    QQuickItem* radiosettings;
    QQuickItem* mediasettings;
    QQuickItem* homeButton;
    QUrl screenUrl;
};

#endif // SETTINGSSCREEN_H

