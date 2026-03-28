import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ColumnLayout {
    id: rebootForm
    anchors.fill: parent
    anchors.margins: 20
    spacing: 15

    property bool animationEnabled: true
    property real animationDuration: 600

    // Trạng thái opacity để điều khiển fade in
    opacity: 0

    Component.onCompleted: {
        if (animationEnabled) {
            entranceAnimation.start();
        } else {
            opacity = 1;
        }
    }

    // Animation khi form xuất hiện
    SequentialAnimation {
        id: entranceAnimation
        NumberAnimation {
            target: rebootForm
            property: "opacity"
            from: 0
            to: 1
            duration: animationDuration * 0.6
            easing.type: Easing.OutCubic
        }
    }

    // Icon xoay
    Image {
        id: rebootIcon
        source: "../Assets/sys-reboot.png"
        Layout.preferredHeight: 80
        Layout.preferredWidth: 80
        Layout.alignment: Qt.AlignHCenter
        fillMode: Image.PreserveAspectFit
        smooth: true

        // Animation xoay liên tục
        RotationAnimation on rotation {
            from: 0
            to: 360
            duration: 2000
            loops: Animation.Infinite
            running: true
        }

        // Hiệu ứng nhấp nháy
        SequentialAnimation on opacity {
            loops: Animation.Infinite
            NumberAnimation {
                from: 0.6
                to: 1.0
                duration: 1000
                easing.type: Easing.InOutSine
            }
            NumberAnimation {
                from: 1.0
                to: 0.6
                duration: 1000
                easing.type: Easing.InOutSine
            }
        }
    }

    // Tiêu đề
    Text {
        id: titleText
        text: "Reboot System"
        color: "#b8c0e0"
        font {
            pixelSize: 28
            family: "ComicShannsMono Nerd Font"
            bold: true
        }
        Layout.alignment: Qt.AlignHCenter

        opacity: 0

        Component.onCompleted: {
            if (animationEnabled) {
                titleAnimation.start();
            } else {
                opacity = 1;
            }
        }

        NumberAnimation {
            id: titleAnimation
            target: titleText
            property: "opacity"
            from: 0
            to: 1
            duration: animationDuration * 0.7
            easing.type: Easing.OutCubic
        }
    }

    // Thông báo xác nhận
    Text {
        id: messageText
        text: "Are you sure you want to reboot the system?\nAll unsaved work will be lost."
        color: "#cad3f5"
        font {
            pixelSize: 16
            family: "ComicShannsMono Nerd Font"
        }
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        Layout.fillWidth: true
        Layout.maximumWidth: parent.width * 0.8
        Layout.alignment: Qt.AlignHCenter

        // Animation fade in
        opacity: 0

        Component.onCompleted: {
            if (animationEnabled) {
                messageAnimation.start();
            } else {
                opacity = 1;
            }
        }

        SequentialAnimation {
            id: messageAnimation
            PauseAnimation {
                duration: 200
            }
            NumberAnimation {
                target: messageText
                property: "opacity"
                from: 0
                to: 1
                duration: animationDuration * 0.6
                easing.type: Easing.OutCubic
            }
        }
    }

    // Bộ đếm ngược
    Rectangle {
        id: countdownContainer
        Layout.preferredHeight: 40
        Layout.fillWidth: true
        Layout.maximumWidth: parent.width * 0.6
        Layout.alignment: Qt.AlignHCenter
        color: "transparent"
        border {
            color: "#494d64"
            width: 2
        }
        radius: 8

        // Thanh tiến trình
        Rectangle {
            id: countdownBar
            width: parent.width
            height: parent.height
            color: "#ed8796"
            radius: parent.radius
            anchors.left: parent.left

            // Animation đếm ngược
            SequentialAnimation on width {
                id: countdownAnimation
                running: false
                NumberAnimation {
                    from: parent.width
                    to: 0
                    duration: 5000  // 5 giây đếm ngược
                    easing.type: Easing.Linear
                }
                ScriptAction {
                    script: {
                        // Tự động reboot sau khi đếm ngược
                        sddm.reboot();
                    }
                }
            }
        }

        // Text đếm ngược
        Text {
            text: "Rebooting in: " + Math.ceil(countdownBar.width / countdownContainer.width * 5) + "s"
            color: "#24273a"
            font {
                pixelSize: 14
                family: "ComicShannsMono Nerd Font"
                bold: true
            }
            anchors.centerIn: parent
        }
    }

    // Nút điều khiển
    RowLayout {
        id: buttonRow
        Layout.alignment: Qt.AlignHCenter
        Layout.topMargin: 20
        spacing: 20

        // Animation scale cho các nút
        scale: 0.8
        opacity: 0

        Component.onCompleted: {
            if (animationEnabled) {
                buttonsAnimation.start();
            } else {
                scale = 1;
                opacity = 1;
            }
        }

        ParallelAnimation {
            id: buttonsAnimation
            NumberAnimation {
                target: buttonRow
                property: "scale"
                from: 0.8
                to: 1.0
                duration: animationDuration
                easing.type: Easing.OutBack
                easing.overshoot: 1.2
            }
            NumberAnimation {
                target: buttonRow
                property: "opacity"
                from: 0
                to: 1
                duration: animationDuration * 0.8
                easing.type: Easing.OutCubic
            }
        }

        // Nút Cancel
        Rectangle {
            id: cancelButton
            Layout.preferredWidth: 120
            Layout.preferredHeight: 45
            color: "#494d64"
            radius: 10
            border {
                color: "#b8c0e0"
                width: 2
            }

            scale: cancelMouseArea.pressed ? 0.95 : 1.0

            Behavior on scale {
                NumberAnimation {
                    duration: 100
                }
            }
            Behavior on border.color {
                ColorAnimation {
                    duration: 200
                }
            }

            Text {
                text: "Cancel"
                color: "#b8c0e0"
                font {
                    pixelSize: 16
                    family: "ComicShannsMono Nerd Font"
                    bold: false
                }
                anchors.centerIn: parent
            }

            MouseArea {
                id: cancelMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    countdownAnimation.stop();
                    formContainer.indexSelect = 0;  // Quay lại login form
                }
                onEntered: parent.border.color = "#ed8796"
                onExited: parent.border.color = "#b8c0e0"
            }
        }

        // Nút Reboot Now
        Rectangle {
            id: rebootNowButton
            Layout.preferredWidth: 140
            Layout.preferredHeight: 45
            color: "#ed8796"
            radius: 10
            border {
                color: "#b8c0e0"
                width: 2
            }

            scale: rebootNowMouseArea.pressed ? 0.95 : 1.0

            Behavior on scale {
                NumberAnimation {
                    duration: 100
                }
            }
            Behavior on border.color {
                ColorAnimation {
                    duration: 200
                }
            }

            Text {
                text: "Reboot Now"
                color: "#24273a"
                font {
                    pixelSize: 16
                    family: "ComicShannsMono Nerd Font"
                    bold: true
                }
                anchors.centerIn: parent
            }

            MouseArea {
                id: rebootNowMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    // Khởi động animation đếm ngược
                    countdownAnimation.start();

                    // Animation khi nhấn reboot
                    pulseAnimation.start();

                    // Thay đổi màu và vô hiệu hóa nút
                    rebootNowButton.color = "#a5adcb";
                    rebootNowButton.border.color = "#a5adcb";
                    cancelButton.enabled = false;
                }
                onEntered: parent.border.color = "#24273a"
                onExited: parent.border.color = "#b8c0e0"
            }
        }
    }

    // Animation nhấp nháy khi nhấn reboot
    SequentialAnimation {
        id: pulseAnimation
        loops: 3
        ParallelAnimation {
            NumberAnimation {
                target: rebootIcon
                property: "scale"
                from: 1.0
                to: 1.2
                duration: 150
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                target: rebootIcon
                property: "opacity"
                from: 1.0
                to: 0.8
                duration: 150
                easing.type: Easing.OutCubic
            }
        }
        ParallelAnimation {
            NumberAnimation {
                target: rebootIcon
                property: "scale"
                from: 1.2
                to: 1.0
                duration: 150
                easing.type: Easing.InCubic
            }
            NumberAnimation {
                target: rebootIcon
                property: "opacity"
                from: 0.8
                to: 1.0
                duration: 150
                easing.type: Easing.InCubic
            }
        }
    }

    // Cảnh báo
    Rectangle {
        Layout.preferredHeight: 60
        Layout.fillWidth: true
        Layout.maximumWidth: parent.width * 0.8
        Layout.alignment: Qt.AlignHCenter
        Layout.topMargin: 10
        color: "#363a4f"
        radius: 8
        border {
            color: "#ed8796"
            width: 1
        }

        Text {
            text: "⚠️ Warning: The system will restart and all unsaved data will be lost."
            color: "#cad3f5"
            font {
                pixelSize: 12
                family: "ComicShannsMono Nerd Font"
            }
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            anchors {
                fill: parent
                margins: 10
            }
        }
    }
}
