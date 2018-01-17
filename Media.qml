import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtMultimedia 5.9
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
//import QtWinExtras 1.0 as Win

Item
{
    visible: true
    id:root
    width: 800
    height: 600

    Background
    {

    }

    MediaPlayer
    {
        id: mediaPlayer
        autoPlay: true
        source: "qrc:/../Imagine Dragons - Believer.mp3"
    }
ColumnLayout
{
    id: column
    RowLayout
{
    id: row

    Button
    {
        id: openButton
        text: qsTr("Open File")
        x: 250
        y: 400
        Layout.preferredWidth: 50
        onClicked: fileDialog.open()

        FileDialog
        {
            id: fileDialog

            folder: musicUrl
            title: qsTr("Open File")
            nameFilters: [qsTr("MP3 files (*.mp3)"), qsTr("All files (*.*)")]
            onAccepted: mediaPlayer.source = fileDialog.fileUrl
        }
    }}

//    Rectangle
//    {
//        id: slider;
//        width:470; height: 20;
//        x:250
//        y:400
//        property int value: Math.round(handle.x*100/(slider.width-handle.width))
//        color: "black"

//        Rectangle
//        {
//            id: handle; width: 20; height: 20; radius: 15;
//            color: "white"

//            MouseArea
//            {
//                anchors.fill: parent
//                drag.target: parent; drag.axis: "XAxis"
//                drag.minimumX: 0; drag.maximumX: slider.width - handle.width
//            }
//        }
//    }

    Slider
    {
        id: positionSlider
        x: 310
        y: 400

        Layout.fillWidth: true
       // maximumValue: mediaPlayer.duration

        property bool sync: false

        onValueChanged:
        {
            if (!sync)
                mediaPlayer.seek(value)
        }

        Connections
        {
            target: mediaPlayer
            onPositionChanged:
            {
                positionSlider.sync = true
                positionSlider.value = mediaPlayer.position
                positionSlider.sync = false
            }
        }
    }

    Label
    {
        id: positionLabel

        readonly property int minutes: Math.floor(mediaPlayer.position / 60000)
        readonly property int seconds: Math.round((mediaPlayer.position % 60000) / 1000)

        text: Qt.formatTime(new Date(0, 0, 0, 0, minutes, seconds), qsTr("mm:ss"))
    }

    Image
    {
        id: musicMain
        width: root.width/5
        height: root.height/3
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: root.width/1.5
        anchors.topMargin: root.height/4.2
        source: "qrc:/IMAGES/Music Main.png"
    }

    Rectangle
    {
        id: mediaRectangle
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
            anchors.horizontalCenter: mediaRectangle.horizontalCenter
            anchors.verticalCenter: mediaRectangle.verticalCenter
            text: "MEDIA" ; font.family: "Lucida Calligraphy"; fontSizeMode: Text.Fit; font.pixelSize: 48
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
        id: forwordleft
        x:250
        y:450
        width: root.width/10
        height: root.height/7.5
        source: "qrc:/IMAGES/Forword left.ico"

        MouseArea
        {
            anchors.fill: forwordleft
            hoverEnabled: true
            onPressed:
            {
                forwordleft.width = forwordleft.width*0.98
                forwordleft.height = forwordleft.height*0.98
                console.log("On forwordleft clicked")
            }
            onReleased:
            {
                forwordleft.width = forwordleft.width/0.98
                forwordleft.height = forwordleft.height/0.98
                console.log("On forwordleft released")
            }
        }
    }

    Image
    {
        id: play
        x:380
        y:450
        width: root.width/10
        height: root.height/7.5
        source: "qrc:/IMAGES/Play-Stop-Pause-Step-Forward.ico"

        MouseArea
        {
            anchors.fill: play
            hoverEnabled: true

            Audio
                {
                  id: playMusic
                  source: "qrc:/../Imagine Dragons - Believer.mp3"
                }

            onPressed:
            {
                play.width = play.width*0.98
                play.height = play.height*0.98
                playMusic.play()
            }
            onReleased:
            {
                play.width = play.width/0.98
                play.height = play.height/0.98
                console.log("On play released")
            }
        }

    }

    Image
    {
        id: stop
        x:510
        y:450
        width: root.width/10
        height: root.height/7.5
        source: "qrc:/IMAGES/Stop1Pressed.png"

        MouseArea
        {
            anchors.fill: stop
            hoverEnabled: true

            onPressed:
            {
                stop.width = stop.width*0.98
                stop.height = stop.height*0.98
                playMusic.stop()
            }
            onReleased:
            {
                stop.width = stop.width/0.98
                stop.height = stop.height/0.98
                console.log("On stop released")
            }
        }
    }

    Image
    {
        id: forwordright
        x:640
        y:450
        width: root.width/10
        height: root.height/7.5
        source: "qrc:/IMAGES/Forward right.jpg"

        MouseArea
        {
            anchors.fill: forwordright
            hoverEnabled: true

            onPressed:
            {
                forwordright.width = forwordright.width*0.98
                forwordright.height = forwordright.height*0.98
                console.log("On forwordright clicked")
            }
            onReleased:
            {
                forwordright.width = forwordright.width/0.98
                forwordright.height = forwordright.height/0.98
                console.log("On forwordright released")
            }
        }
    }

    Rectangle
    {
        id: trackName
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
            anchors.horizontalCenter: trackName.horizontalCenter
            anchors.verticalCenter: trackName.verticalCenter
            text: "Track Name" ; font.family: "Lucida Calligraphy"; fontSizeMode: Text.Fit; font.pixelSize :28
        }
    }

    ListModel
    {
        id:medialist
        ListElement { name: "USB" }
        ListElement { name: "SD" }
        ListElement { name: "CD" }
        ListElement { name: "DVD" }
        ListElement { name: "BT" }
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
                height: 96
                border.color: "black"
                color: ListView.isCurrentItem ? "#C1FFC1" : "#C1FFC1"

                Text
                {
                    anchors.horizontalCenter: wrapper.horizontalCenter
                    anchors.verticalCenter: wrapper.verticalCenter
                    id: medialist
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
                        console.log("On entered")
                    }

                    onExited:
                    {
                        wrapper.color="#C1FFC1"
                        wrapper.border.color = "Black"
                        console.log("On exited")
                    }

                    onPressed:
                    {
                        wrapper.width = wrapper.width*0.98
                        wrapper.height = wrapper.height*0.98
                        console.log("On Media Button clicked")
                    }

                    onReleased:
                    {
                        wrapper.width = wrapper.width/0.98
                        wrapper.height = wrapper.height/0.98
                        console.log("On Media Button released")
                    }
                }
            }
        }

        delegate: contactsDelegate
        model: medialist
        focus: true
    }
}

}
