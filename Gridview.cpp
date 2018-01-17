#include "Gridview.h"

void Gridview::gridMembers()
{
    StrucData radio,media,phone,navi,settings;

    radio.url = "qrc:/IMAGES/Radio.png";
    addEntry(radio);

    media.url = "qrc:/IMAGES/Media.png";
    addEntry(media);

    phone.url = "qrc:/IMAGES/phone.png";
    addEntry(phone);

    navi.url = "qrc:/IMAGES/Navi..png";
    addEntry(navi);

    settings.url = "qrc:/IMAGES/Settings...png";
    addEntry(settings);
}

QVariant Gridview:: data(const QModelIndex &index, int role) const
{
    int row = index.row();

    if ((row<0) ||(row>= item.count()))
    {
        return QVariant();
    }

    StrucData data = item.at(row);
    switch (role)
    {
    case 1:
        return data.url;
    default:
        break;
    }

    return QVariant();
}

int Gridview::rowCount(const QModelIndex&) const
{
    return item.count();
}

QHash<int,QByteArray> Gridview::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[1]= "url";
    return roles;
}

void Gridview:: addEntry(const StrucData newScreen)
{
    int row=item.count();
    beginInsertRows(QModelIndex(),row,row);
    item.append(newScreen);
    endInsertRows();
}
