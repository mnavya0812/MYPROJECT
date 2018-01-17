import QtQuick 2.8
import QtQuick.Window 2.2

Item
{
    visible: true
    id:root
    width: 800
    height: 600

    Background
    {

    }

    Image
    {
        id: tower
        width: root.width/5
        height: root.height/3
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: root.width/1.5
        anchors.topMargin: root.height/4.2
        source: "qrc:/IMAGES/RadioTower.png"
    }

    Rectangle
    {
        id: radioRectangle
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
            anchors.horizontalCenter: radioRectangle.horizontalCenter
            anchors.verticalCenter: radioRectangle.verticalCenter
            text: "RADIO" ; font.family: "Lucida Calligraphy"; fontSizeMode: Text.Fit; font.pixelSize: 48
        }
    }

    HomeButton
    {
        id:home
        objectName: "home"
        signal refresh(var home1)
    }

    Rectangle
    {
        id: autoTune
        height: 100
        width: 250
        x:250
        y:400
        gradient: Gradient
        {
            GradientStop{position: 0.0; color: "#4682B4"}
            GradientStop{position: 0.5; color: "#668B8B"}
            GradientStop{position: 1.0; color: "#4682B4"}
        }

        Text
        {
            anchors.horizontalCenter: autoTune.horizontalCenter
            anchors.verticalCenter: autoTune.verticalCenter
            text: "AUTO TUNE" ; font.family: "Lucida Calligraphy"; fontSizeMode: Text.Fit; font.pixelSize: 28
        }

        MouseArea
        {
            anchors.fill: autoTune
            hoverEnabled: true

            onPressed:
            {
                autoTune.width = autoTune.width*0.98
                autoTune.height = autoTune.height*0.98
                console.log("On autoTune clicked")
            }

            onReleased:
            {
                autoTune.width = autoTune.width/0.98
                autoTune.height = autoTune.height/0.98
                console.log("On autoTune released")
            }
        }
    }

    Rectangle
    {
        id: browse
        height: 100
        width: 220
        x:550
        y:400
        objectName: "browse"
        signal refresh(var home1)
        gradient: Gradient
        {
            GradientStop{position: 0.0; color: "#4682B4"}
            GradientStop{position: 0.5; color: "#668B8B"}
            GradientStop{position: 1.0; color: "#4682B4"}
        }

        Text
        {
            anchors.horizontalCenter: browse.horizontalCenter
            anchors.verticalCenter: browse.verticalCenter
            text: "BROWSE" ; font.family: "Lucida Calligraphy"; fontSizeMode: Text.Fit; font.pixelSize :28
        }

        MouseArea
        {
            anchors.fill: browse
            objectName: browse.objectName
            hoverEnabled: true

            onPressed:
            {
                browse.width = browse.width*0.98
                browse.height = browse.height*0.98
                //                console.log("On browse clicked")
            }

            onReleased:
            {
                browse.width = browse.width/0.98
                browse.height = browse.height/0.98
                //                console.log("On browse released")
                browse.refresh("browse")
                //                rootWindow.changeScreen("qrc:/Stations.qml")
            }
        }
    }

    Rectangle
    {
        id: fmBar
        height: 60
        width: 220
        x:250
        y:150
        gradient: Gradient
        {
            GradientStop{position: 0.0; color: "#4682B4"}
            GradientStop{position: 0.5; color: "#668B8B"}
            GradientStop{position: 1.0; color: "#4682B4"}
        }

        Text
        {
            anchors.horizontalCenter: fmBar.horizontalCenter
            anchors.verticalCenter: fmBar.verticalCenter
            text: "FM/AM/SXM" ; font.family: "Lucida Calligraphy"; fontSizeMode: Text.Fit; font.pixelSize :20
        }
    }

    Rectangle
    {
        id: stationBar
        height: 60
        width: 220
        x:250
        y:230
        gradient: Gradient
        {
            GradientStop{position: 0.0; color: "#4682B4"}
            GradientStop{position: 0.5; color: "#668B8B"}
            GradientStop{position: 1.0; color: "#4682B4"}
        }

        Text
        {
            anchors.horizontalCenter: stationBar.horizontalCenter
            anchors.verticalCenter: stationBar.verticalCenter
            text: "STATION NAME" ; font.family: "Lucida Calligraphy"; fontSizeMode: Text.Fit; font.pixelSize :20
        }
    }

    Rectangle
    {
        id: frequencyBar
        height: 60
        width: 220
        x:250
        y:310
        gradient: Gradient
        {
            GradientStop{position: 0.0; color: "#4682B4"}
            GradientStop{position: 0.5; color: "#668B8B"}
            GradientStop{position: 1.0; color: "#4682B4"}
        }

        Text
        {
            anchors.horizontalCenter: frequencyBar.horizontalCenter
            anchors.verticalCenter: frequencyBar.verticalCenter
            text: "FREQUENCY" ; font.family: "Lucida Calligraphy"; fontSizeMode: Text.Fit; font.pixelSize :20
        }
    }

    ListModel
    {
        id:radiolist
        ListElement { name: "PRE1" }
        ListElement { name: "PRE2" }
        ListElement { name: "PRE3" }
        ListElement { name: "PRE4" }
        ListElement { name: "PRE5" }
        ListElement { name: "PRE6" }
    }

    ListView
    {
        width: 180; height: 480
        x: 0
        y: 120

        Component
        {
            id: contactsDelegate

            Rectangle
            {
                id: wrapper
                width: 180
                height: 80
                border.color: "black"
                color: ListView.isCurrentItem ? "#C1FFC1" : "#C1FFC1"

                Text
                {
                    anchors.horizontalCenter: wrapper.horizontalCenter
                    anchors.verticalCenter: wrapper.verticalCenter
                    id: radiolist
                    text: name ; font.family: "Lucida Calligraphy"; fontSizeMode: Text.Fit; font.pixelSize: 36
                }

                MouseArea
                {
                    anchors.fill: wrapper
                    hoverEnabled: true

                    onEntered:
                    {
                        wrapper.color = "#708090"
                        wrapper.border.color = "black"
                    }

                    onExited:
                    {
                        wrapper.color="#C1FFC1"
                        wrapper.border.color = "Black"
                    }

                    onPressed:
                    {
                        wrapper.width = wrapper.width*0.98
                        wrapper.height = wrapper.height*0.98
                    }

                    onReleased:
                    {
                        wrapper.width = wrapper.width/0.98
                        wrapper.height = wrapper.height/0.98
                    }
                }
            }
        }

        delegate: contactsDelegate
        model: radiolist
        focus: true
    }
}
