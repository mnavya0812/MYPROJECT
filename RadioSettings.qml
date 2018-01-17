import QtQuick 2.8
import QtQuick.Window 2.2


Item
{
    id:root
    visible: true
    width: 800
    height: 600

    Background
    {

    }

    Rectangle
    {
        id: settingsRectangle
        height: root.height/5
        width: root.width
        gradient: Gradient
        {
            GradientStop{position: 0.0; color: "#4682B4"}
            GradientStop{position: 0.5; color: "#668B8B"}
            GradientStop{position: 1.0; color: "#4682B4"}
        }

        Text
        {
            anchors.horizontalCenter: settingsRectangle.horizontalCenter
            anchors.verticalCenter: settingsRectangle.verticalCenter
            text: "RADIO SETTINGS" ; font.family: "Lucida Calligraphy"; fontSizeMode: Text.Fit; font.pixelSize: 48
        }
    }

    HomeButton
    {
        id:home
        objectName: "home"
        signal refresh(var home1)
    }

    ListModel
    {
        id: settingsList
        ListElement { name: "FM" }
        ListElement { name: "AM" }
        ListElement { name: "SXM" }
    }

    ListView
    {
        id: settingsListView
        width: 200; height: 480
        x: 0
        y: 120

        Component
        {
            id: settingsDelegate

            Rectangle
            {
                id: settingsWrapper
                width: 200
                height: 160
                border.color: "black"
                color: ListView.isCurrentItem ? "#C1FFC1" : "#C1FFC1"

                Text
                {
                    anchors.verticalCenter: settingsWrapper.verticalCenter
                    id: radiolist
                    text: name ; font.family: "Lucida Calligraphy"; fontSizeMode: Text.Fit; font.pixelSize: 36
                }

                MouseArea
                {
                    anchors.fill: settingsWrapper
                    hoverEnabled: true

                    onEntered:
                    {
                        settingsWrapper.color = "#708090"
                        settingsWrapper.border.color = "Black"
                        console.log("On entered")
                    }

                    onExited:
                    {
                        settingsWrapper.color="#C1FFC1"
                        settingsWrapper.border.color = "Black"
                        console.log("On exited")
                    }

                    onPressed:
                    {
                        settingsWrapper.width = settingsWrapper.width*0.98
                        settingsWrapper.height = settingsWrapper.height*0.98
                        console.log("On clicked")
                    }

                    onReleased:
                    {
                        settingsWrapper.width = settingsWrapper.width/0.98
                        settingsWrapper.height = settingsWrapper.height/0.98
                        console.log("On released")
                    }
                }
            }
        }

        delegate: settingsDelegate
        model: settingsList
        focus: true
    }
}
