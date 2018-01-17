#ifndef GRIDVIEW_H
#define GRIDVIEW_H

#include <QAbstractItemModel>
#include <QtCore>
#include <QtGui>
#include <QAbstractListModel>
#include <QObject>

typedef struct StrucData
{
    QString url;
}

StrucData;

class Gridview : public QAbstractListModel

{    
public:
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
    virtual QHash<int,QByteArray> roleNames() const;
    void addEntry(const StrucData newScreen);
    void gridMembers();

    int m_index;

    QList<StrucData> item;
};

#endif // GRIDVIEW_H
