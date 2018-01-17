#include "ListView.h"

void ListView::listMembers()
{
    StructData radiosettings,mediasettings,phonesettings,navisettings;

    radiosettings.name = "RADIO";
    addEntry(radiosettings);

    mediasettings.name = "MEDIA";
    addEntry(mediasettings);

    phonesettings.name = "PHONE";
    addEntry(phonesettings);

    navisettings.name = "NAVI";
    addEntry(navisettings);
}

QVariant ListView:: data(const QModelIndex &index, int role) const
{
    int row = index.row();

    if ((row<0) ||(row>= item.count()))
    {
        return QVariant();
    }

    StructData data = item.at(row);
    switch (role)
    {
    case 1:
        return data.name;
    default:
        break;
    }

    return QVariant();
}

int ListView::rowCount(const QModelIndex&) const
{
    return item.count();
}

QHash<int,QByteArray> ListView::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[1]= "name";
    return roles;
}

void ListView:: addEntry(const StructData newScreen)
{   int row=item.count();
    beginInsertRows(QModelIndex(),row,row);
    item.append(newScreen);
    endInsertRows();
}
