import QtQuick
import QtQuick.Layouts

Item {
    id: titleBar

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 15
        anchors.rightMargin: 15
        spacing: 10
        Item {Layout.fillWidth: true}

        // Hình tròn đỏ (đóng)
        Rectangle {
            id: closeCircle
            Layout.preferredWidth: 16
            Layout.preferredHeight: 16
            radius: width / 2
            color: "#ed8796"

            SequentialAnimation on opacity {
                running: true
                loops: Animation.Infinite

                NumberAnimation {
                    to: 0.5
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    to: 1
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }
            }
        }

        // Hình tròn vàng (thu nhỏ)
        Rectangle {
            id: minimizeCircle
            Layout.preferredWidth: 16
            Layout.preferredHeight: 16
            radius: width / 2
            color: "#eed49f"

            SequentialAnimation on opacity {
                running: true
                loops: Animation.Infinite

                NumberAnimation {
                    to: 1
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    to: 0.5
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }
            }
        }

        // Hình tròn xanh lá (phóng to)
        Rectangle {
            id: maximizeCircle
            Layout.preferredWidth: 16
            Layout.preferredHeight: 16
            radius: width / 2
            color: "#a6da95"

            SequentialAnimation on opacity {
                running: true
                loops: Animation.Infinite

                NumberAnimation {
                    to: 0.5
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }
                PauseAnimation {
                    duration: 500
                }
                NumberAnimation {
                    to: 1
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }
                PauseAnimation {
                    duration: 500
                }
            }
        }

        // Spacer để đẩy các hình tròn sang trái


        // Các hình tròn màu khác có thể thêm ở đây nếu muốn
        Rectangle {
            id: blueCircle
            Layout.preferredWidth: 16
            Layout.preferredHeight: 16
            radius: width / 2
            color: "#8aadf4"
            visible: false
        }

        Rectangle {
            id: magentaCircle
            Layout.preferredWidth: 16
            Layout.preferredHeight: 16
            radius: width / 2
            color: "#f5bde6"
            visible: false
        }

        Rectangle {
            id: cyanCircle
            Layout.preferredWidth: 16
            Layout.preferredHeight: 16
            radius: width / 2
            color: "#8bd5ca"
            visible: false
        }
    }
}
