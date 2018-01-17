import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1
import QtQuick.Window 2.3

Item
{
    id: root
    visible: true
    width: 800
    height: 600

    Background
    {

    }

    Flickable
    {
        id:flickable
        clip:true
        anchors.fill: parent
        ScrollIndicator.vertical: ScrollIndicator { }
        contentWidth: 100
        contentHeight: 480
    }

    Rectangle
    {
        id: stationListRectangle
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
            anchors.horizontalCenter: stationListRectangle.horizontalCenter
            anchors.verticalCenter: stationListRectangle.verticalCenter
            text: "STATIONS" ; font.family: "Lucida Calligraphy"; fontSizeMode: Text.Fit; font.pixelSize: 48
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
        id: stationsList
        ListElement { name: "97.7-1. FM" }
        ListElement { name: "98.5-1. FM" }
        ListElement { name: "98.5-2 FM" }
        ListElement { name: "104.9-1. FM" }
        ListElement { name: "105.7-1. FM" }
        ListElement { name: "1170. AM" }
    }

    ListView
    {
        id: stationsListView
        width: 700; height: 480
        y: 120

        Component
        {
            id: stationsDelegate

            Rectangle
            {
                id: stationsWrapper
                width: 700
                height: 80
                border.color: "black"
                color: ListView.isCurrentItem ? "#C1FFC1" : "#C1FFC1"

                Text
                {
                    anchors.verticalCenter: stationsWrapper.verticalCenter
                    id: radiolist
                    text: name ; font.family: "Lucida Calligraphy"; fontSizeMode: Text.Fit; font.pixelSize: 28
                }

                MouseArea
                {
                    anchors.fill: stationsWrapper
                    hoverEnabled: true

                    onEntered:
                    {
                        stationsWrapper.color = "#708090"
                        stationsWrapper.border.color = "black"
                    }

                    onExited:
                    {
                        stationsWrapper.color="#C1FFC1"
                        stationsWrapper.border.color = "Black"
                        console.log("On exited")
                    }

                    onPressed:
                    {
                        stationsWrapper.width = stationsWrapper.width*0.98
                        stationsWrapper.height = stationsWrapper.height*0.98
                        console.log("On clicked")
                    }

                    onReleased:
                    {
                        stationsWrapper.width = stationsWrapper.width/0.98
                        stationsWrapper.height = stationsWrapper.height/0.98
                        console.log("On released")

                    }
                }
            }
        }

        delegate: stationsDelegate
        model: stationsList
        focus: true
    }
}
