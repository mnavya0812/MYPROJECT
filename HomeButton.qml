import QtQuick 2.0

Item
{
    id: root
    visible: true
    width: 800
    height: 600

    Image
    {
        id: home1
        anchors.topMargin:root.height/30
        width: root.width/8
        height: root.height/6
        source: "qrc:/IMAGES/Home.png"
        fillMode: Image.PreserveAspectFit

        MouseArea
        {
            anchors.fill: home1
            objectName: home1.objectName

            onPressed:
            {
                home1.height=100*(3/4)
                home1.width=100*(3/4)
            }

            onReleased:
            {
                home1.height=root.height/6
                home1.width=root.width/8
                home.refresh("home")
            }
        }
    }
}
