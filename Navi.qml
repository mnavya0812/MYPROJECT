import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 2.2

Item
{
    visible: true
    id:root
    width: 800
    height: 600

    Rectangle
    {
        id: naviRectangle
        height: 120
        width: 800
        gradient: Gradient
        {
            GradientStop{position: 0.0; color: "#4682B4"}
            GradientStop{position: 0.5; color: "#668B8B"}
            GradientStop{position: 1.0; color: "#4682B4"}
        }

        Text
        {
            anchors.horizontalCenter: naviRectangle.horizontalCenter
            anchors.verticalCenter: naviRectangle.verticalCenter
            text: "NAVIGATION" ; font.family: "Lucida Calligraphy"; fontSizeMode: Text.Fit; font.pixelSize: 48
        }
    }

    HomeButton
    {
        id:home
        objectName: "home"
        signal refresh(var home1)
    }

    Image
    {
        y:100
        width: 800
        height: 500
        source: "qrc:/IMAGES/Navi.jpg"
    }
}


