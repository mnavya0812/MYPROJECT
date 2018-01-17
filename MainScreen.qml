import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2

Item
{
    signal refreshScreen(var value)
    objectName: "mainScreen"
    visible: true
    width: 800
    height: 600
    id: window

    Image
    {
        anchors.fill:parent
        source:"qrc:/IMAGES/Background.jpg"
    }

    Item
    {
        id: rootItem
        x: window.width/16
        y: window.height/12
        visible: true
        width: Window.width
        height: Window.height
        objectName: "FirstScreenRectangle"

        ListModel
        {
            id: appModel
        }

        GridView
        {
            id: gridview
            model: appModel
            anchors.fill: rootItem
            cellWidth : rootItem.width/3
            cellHeight: rootItem.height/2
            focus: true
            objectName: "gridview"

            signal pressed()
            signal released(int index)
            signal entered
            signal exited
            delegate:

                Rectangle
            {
                id: delegateRootItem
                width: gridview.cellWidth/2
                height: gridview.cellHeight/2
                color: "transparent"

                Rectangle
                {
                    id: rectangle
                    width: myIcon.width*1.2
                    height: myIcon.height*1.2
                    anchors.fill: delegateRootItem
                    color: "transparent"
                }

                Image
                {
                    id: myIcon
                    fillMode: Image.PreserveAspectFit
                    anchors.fill: delegateRootItem
                    width: delegateRootItem.width/2
                    height: delegateRootItem.height/2
                    source: url
                }

                Text
                {
                    id:textArea1
                    anchors
                    {
                        top: myIcon.bottom;
                        topMargin: parent.height* 15/600
                        horizontalCenter: myIcon.horizontalCenter
                    }

                    color: "#708090"
                    font.pointSize: gridview.width*0.017
                    font.bold:true
                    font.family: "Lucida Calligraphy"
                }

                MouseArea
                {
                    objectName: gridview.objectName
                    anchors.fill: myIcon
                    hoverEnabled: true

                    onPressed:
                    {
                        delegateRootItem.width = myIcon.width*0.9
                        delegateRootItem.height = myIcon.height*0.9

                        gridview.pressed(index);
                    }

                    onReleased:
                    {
                        delegateRootItem.width = window.width/6
                        delegateRootItem.height = window.height/4

                        gridview.released(index);
                    }

                    onEntered:
                    {
                        rectangle.color = "#708090"
                        rectangle.border.color = "transparent"
                        rectangle.radius = 10
                        //                        gridView.entered();
                    }

                    onExited:
                    {
                        rectangle.color="Transparent"
                        rectangle.border.color = "Transparent"
                        myIcon.opacity = 1
                        //                        gridView.exited();
                    }
                }
            }
        }
    }
}
