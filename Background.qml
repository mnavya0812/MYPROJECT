import QtQuick 2.0
import QtQuick.Window 2.2

Item
{
    id: rootWindow
    visible: true
    width: 800
    height: 600

    Image
    {
        id: background
        anchors.fill: parent
        width: rootWindow.width
        height: rootWindow.height
        source: "qrc:/IMAGES/Background.jpg"
    }
}
