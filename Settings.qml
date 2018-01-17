import QtQuick 2.8
import QtQuick.Window 2.2

Item
{
    signal refreshScreen(var value)
    id: root
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
            text: "SETTINGS" ; font.family: "Lucida Calligraphy"; fontSizeMode: Text.Fit; font.pixelSize: 48
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
    }

    ListView
    {
        id: settingsListView
        width: 800; height: 480
        y: 120
        objectName: "settingsListView"
        signal pressed()
        signal released(int index)
        signal entered
        signal exited

        Component
        {
            id: settingsDelegate

            Rectangle
            {
                id: settingsWrapper
                width: 800
                height: 120
                border.color: "black"
                color: ListView.isCurrentItem ? "#C1FFC1" : "#C1FFC1"

                Text
                {
                    id:textArea1
                    anchors.verticalCenter: settingsWrapper.verticalCenter
                    text: name
                    fontSizeMode: Text.Fit
                    font.pixelSize: 36
                    font.family: "Lucida Calligraphy"
                }

                MouseArea
                {
                    objectName: settingsListView.objectName
                    anchors.fill: settingsWrapper
                    hoverEnabled: true

                    onEntered:
                    {
                        settingsWrapper.color = "#708090"
                        settingsWrapper.border.color = "Black"
                        //   console.log("On entered")
                    }

                    onExited:
                    {
                        settingsWrapper.color="#C1FFC1"
                        settingsWrapper.border.color = "Black"
                        //  console.log("On exited")
                    }

                    onPressed:
                    {
                        settingsWrapper.width = settingsWrapper.width*0.98
                        settingsWrapper.height = settingsWrapper.height*0.98
                    }

                    onReleased:
                    {
                        settingsWrapper.width = settingsWrapper.width/0.98
                        settingsWrapper.height = settingsWrapper.height/0.98
                        settingsListView.released(index)
                    }
                }
            }
        }

        delegate: settingsDelegate
        model: settingsList
        focus: true
    }
}
