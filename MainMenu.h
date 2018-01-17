#ifndef MAINMENU_H
#define MAINMENU_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <Gridview.h>
#include <RadioScreen.h>
#include <MediaScreen.h>
#include <PhoneScreen.h>
#include <NaviScreen.h>
#include <SettingsScreen.h>

class RadioScreen;
class MediaScreen;
class PhoneScreen;
class NaviScreen;
class SettingsScreen;

class MainMenu : public QObject
{
    Q_OBJECT

public:
    explicit MainMenu(QObject *parent = nullptr);
    void display();
    void setEngine(QQmlApplicationEngine *engine);
    RadioScreen* radioScreen;
    MediaScreen* mediaScreen;
    PhoneScreen* phoneScreen;
    NaviScreen* naviScreen;
    SettingsScreen* settingsScreen;

public slots:
    void onReleased(int index);

private:
    QQmlApplicationEngine* m_engine;
    QQuickWindow* m_window;
};

#endif // MAINMENU_H
