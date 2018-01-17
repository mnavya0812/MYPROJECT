#ifndef LISTVIEW_H
#define LISTVIEW_H

#include <QObject>
#include <QAbstractItemModel>
#include <QtCore>
#include <QtGui>
#include <QAbstractListModel>

typedef struct StructData
{
    QString name;
}

StructData;

class ListView : public QAbstractListModel
{
public:
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
    virtual QHash<int,QByteArray> roleNames() const;

    void addEntry(const StructData newScreen);
    void listMembers();

    int m_index;

    QList<StructData> item;
};

#endif // LISTVIEW_H

