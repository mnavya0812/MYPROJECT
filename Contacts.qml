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
        id: contactsListRectangle
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
            anchors.horizontalCenter: contactsListRectangle.horizontalCenter
            anchors.verticalCenter: contactsListRectangle.verticalCenter
            text: "CONTACTS" ; font.family: "Lucida Calligraphy"; fontSizeMode: Text.Fit; font.pixelSize: 48
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
        id: contactsList
        ListElement { name: "Alex" }
        ListElement { name: "Brandon" }
        ListElement { name: "Cahill" }
        ListElement { name: "David" }
        ListElement { name: "Elenor" }
        ListElement { name: "Felicity" }
        ListElement { name: "George" }
        ListElement { name: "Harry" }
        ListElement { name: "Ian" }
        ListElement { name: "Jon" }
        ListElement { name: "Kate" }
        ListElement { name: "Lionel" }
    }

    ListView
    {
        id: contactsListView
        width: 700; height: 480
        y: 120

        Component
        {
            id: contactsDelegate

            Rectangle
            {
                id: contactsWrapper
                width: 700
                height: 40
                border.color: "black"
                color: ListView.isCurrentItem ? "#C1FFC1" : "#C1FFC1"

                Text
                {
                    anchors.verticalCenter: contactsWrapper.verticalCenter
                    id: contactlist
                    text: name ; font.family: "Lucida Calligraphy"; fontSizeMode: Text.Fit; font.pixelSize: 15}

                MouseArea
                {
                    anchors.fill: contactsWrapper
                    hoverEnabled: true

                    onEntered:
                    {
                        contactsWrapper.color = "#708090"
                        contactsWrapper.border.color = "black"
                    }

                    onExited:
                    {
                        contactsWrapper.color="#C1FFC1"
                        contactsWrapper.border.color = "Black"
                        console.log("On exited")
                    }

                    onPressed:
                    {
                        contactsWrapper.width = contactsWrapper.width*0.98
                        contactsWrapper.height = contactsWrapper.height*0.98
                        console.log("On clicked")
                    }

                    onReleased:
                    {
                        contactsWrapper.width = contactsWrapper.width/0.98
                        contactsWrapper.height = contactsWrapper.height/0.98
                        console.log("On released")
                    }
                }
            }
        }

        delegate: contactsDelegate
        model: contactsList
        focus: true
    }
}
