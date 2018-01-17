import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2

Item {
    id:root
    visible: true
    width: 800
    height: 600

    Background
    {

    }

    Rectangle
    {
        id: dial
        height: root.height/6
        width: root.width*3/5
        color: "light blue"
        border.color: "black"
    }

    TextEdit
    {
        id: textEdit
        anchors.horizontalCenter: dial.horizontalCenter
        anchors.verticalCenter: dial.verticalCenter
        font.pointSize: dial.width/12
        color: "black"
        focus: true
        font.family: "Lucida Calligraphy"
        horizontalAlignment: TextEdit.AlignRight
    }

    Rectangle
    {
        id: clearButton
        x: 600
        y: 120
        height: 60
        width: 140
        color: "Red"

        Text
        {
            text: "Clear"
            font.pointSize: clearButton.width/10
            font.family: "Lucida Calligraphy"
            anchors.horizontalCenter: clearButton.horizontalCenter
            anchors.verticalCenter: clearButton.verticalCenter
        }

        MouseArea
        {
            anchors.fill: clearButton
            hoverEnabled: true

            onEntered:
            {
                clearButton.color = "light green"
                clearButton.border.color = "transparent"
                clearButton.radius = clearButton.width/60
                console.log("On entered")
            }

            onExited:
            {
                clearButton.color="light gray"
                clearButton.border.color = "transparent"
                clearButton.opacity=1
                console.log("On exited")
            }

            onPressed:
            {
                clearButton.color="light Blue"
                clearButton.width = clearButton.width*0.98
                clearButton.height = clearButton.height*0.98
                textEdit.text = " "
                console.log("On clicked")
            }

            onReleased:
            {
                clearButton.color="light gray"
                clearButton.width = clearButton.width/0.98
                clearButton.height = clearButton.height/0.98
                console.log("On released")
            }
        }
    }

    Rectangle
    {
        id: contactsButton
        x: 600
        y: 400
        height: 60
        width: 140
        color: "light gray"

        Text
        {
            text: "Contacts"
            font.pointSize: contactsButton.width/10
            font.family: "Lucida Calligraphy"
            anchors.horizontalCenter: contactsButton.horizontalCenter
            anchors.verticalCenter: contactsButton.verticalCenter
        }

        MouseArea
        {
            anchors.fill: contactsButton
            hoverEnabled: true

            onEntered:
            {
                contactsButton.color = "light green"
                contactsButton.border.color = "transparent"
                contactsButton.radius = contactsButton.width/60
                console.log("On entered")
            }

            onExited:
            {
                contactsButton.color="Light Blue"
                contactsButton.border.color = "transparent"
                contactsButton.opacity=1
                console.log("On exited")
            }

            onPressed:
            {
                contactsButton.width = contactsButton.width*0.98
                contactsButton.height = contactsButton.height*0.98
                console.log("On clicked")
            }

            onReleased:
            {
                contactsButton.width = contactsButton.width/0.98
                contactsButton.height = contactsButton.height/0.98
                console.log("On released")
            }
        }
    }

    Rectangle
    {
        id: callButton
        y: root.height*5/6
        height: root.height/6
        width: root.width*0.6
        color: "green"

        Text
        {
            text: "call"
            font.pointSize: callButton.width/10
            font.family: "Lucida Calligraphy"
            anchors.horizontalCenter: callButton.horizontalCenter
            anchors.verticalCenter: callButton.verticalCenter
        }

        MouseArea
        {
            anchors.fill: callButton
            hoverEnabled: true

            onEntered:
            {
                callButton.color = "light green"
                callButton.border.color = "transparent"
                callButton.radius = callButton.width/60
                console.log("On entered")
            }

            onExited:
            {
                callButton.color="green"
                callButton.border.color = "transparent"
                callButton.opacity=1
                console.log("On exited")
            }

            onPressed:
            {
                callButton.width = callButton.width*0.98
                callButton.height = callButton.height*0.98
                console.log("On clicked")
            }
            onReleased:
            {
                callButton.width = callButton.width/0.98
                callButton.height = callButton.height/0.98
                console.log("On released")
            }
        }
    }

    Rectangle
    {
        id: rootItem
        visible: true
        y: root.height/6
        //        anchors.fill: root
        width: root.width*3/5
        height: root.height*4/6
        color: "transparent"

        ListModel
        {
            id: appModel
            ListElement{name: "7" }
            ListElement{name: "8" }
            ListElement{name: "9" }
            ListElement{name: "4" }
            ListElement{name: "5" }
            ListElement{name: "6" }
            ListElement{name: "1" }
            ListElement{name: "2" }
            ListElement{name: "3" }
            ListElement{name: "*" }
            ListElement{name: "0" }
            ListElement{name: "#" }
        }

        GridView
        {
            id: gridView
            model: appModel
            anchors.fill: rootItem
            cellWidth : rootItem.width/3
            cellHeight: rootItem.height/4
            focus: true

            delegate:

                Rectangle
            {
                id: delegateRootItem
                width: gridView.cellWidth
                height: gridView.cellHeight
                color: "light blue"
                border.color: "black"
                //                border.width: gridView.cellWidth/100

                Rectangle
                {
                    id: rectangle
                    width: myIcon.width*1.2
                    height: myIcon.height*1.2
                    anchors.fill: delegateRootItem
                    color: "transparent"
                }

                Text
                {
                    id: myIcon
                    text: name
                    font.pixelSize: delegateRootItem.width/1.8
                    font.family: "Lucida Calligraphy"
                    anchors.horizontalCenter: delegateRootItem.horizontalCenter
                    anchors.verticalCenter: delegateRootItem.verticalCenter
                }

                MouseArea
                {
                    anchors.fill: delegateRootItem
                    hoverEnabled: true

                    onEntered:
                    {
                        rectangle.color = "#708090"
                        rectangle.border.color = "transparent"
                        rectangle.radius = delegateRootItem.width/60
                        console.log("On entered")
                    }

                    onExited:
                    {
                        rectangle.color="Transparent"
                        rectangle.border.color = "Transparent"
                        myIcon.opacity=1
                        console.log("On exited")
                    }

                    onPressed:
                    {
                        delegateRootItem.width = delegateRootItem.width*0.98
                        delegateRootItem.height = delegateRootItem.height*0.98
                        if (textEdit.length<10){textEdit.text= textEdit.text+ name;}
                        else { textEdit.readOnly=true;}
                        console.log("On clicked")
                    }

                    onReleased:
                    {
                        delegateRootItem.width = delegateRootItem.width/0.98
                        delegateRootItem.height = delegateRootItem.height/0.98
                        console.log("On released")
                    }
                }
            }
        }
    }

    HomeButton
    {
        id:home
        objectName: "home"
        signal refresh(var home1)
    }
}
