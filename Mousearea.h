#ifndef MOUSEAREA_H
#define MOUSEAREA_H
#include <QVariant>
#include <QQuickItem>
#include <QObject>

class Mousearea : public QObject
{
    Q_OBJECT

public:
    explicit Mousearea(QObject *parent = nullptr);
    void setScreen1(QQuickItem* rootItem);

public slots:
    void onPressed();
    void onReleased();
    void onEntered();
    void onExited();

private :
    QQuickItem* mScreen1RootItem;
};

#endif // MOUSEAREA_H
