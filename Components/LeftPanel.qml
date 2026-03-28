import QtQuick
import QtQuick.Layouts

Rectangle {
    id: leftPanel
    color: "transparent"
    Layout.fillHeight: true
    Layout.preferredWidth: mouseAreaPanel.containsMouse ? parent.width * 0.25 : parent.width * 0.1
    signal indexChanged(int index)
    radius: 32
    border {
        color: "#b8c0e0"
        width: 3
    }

    // Behavior cho width thay đổi mượt mà
    Behavior on Layout.preferredWidth {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 10

        // Login Button - Chỉ có click, không có hover
        Rectangle {
            id: loginButton
            Layout.preferredHeight: parent.height * 0.1
            Layout.fillWidth: true
            color: "#494d64"  // Màu cố định, không đổi khi hover
            radius: 16
            border {
                color: "#b8c0e0"
                width: 3
            }

            scale: mouseAreaLogin.pressed ? 0.98 : 1.0
            Behavior on scale {
                NumberAnimation {
                    duration: 100
                }
            }
            Behavior on border.color {
                ColorAnimation {
                    duration: 100
                }
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 16

                Image {
                    source: "../Assets/login.png"
                    Layout.preferredHeight: 28
                    Layout.preferredWidth: 28
                    fillMode: Image.PreserveAspectFit
                    smooth: true

                    rotation: mouseAreaPanel.containsMouse ? 360 : 0
                    Behavior on rotation {
                        NumberAnimation {
                            duration: 500
                            easing.type: Easing.OutCubic
                        }
                    }
                }

                Text {
                    text: "Login"
                    color: "#b8c0e0"
                    visible: mouseAreaPanel.containsMouse
                    Layout.fillWidth: true

                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    font {
                        pixelSize: 20
                        family: "ComicShannsMono Nerd Font"
                        bold: false
                    }
                }
            }

            MouseArea {
                id: mouseAreaLogin
                anchors.fill: parent
                hoverEnabled: false  // Tắt hover
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    // Xử lý login
                    indexChanged(0);
                }
            }
        }

        // Settings Button - Chỉ có click, không có hover
        Rectangle {
            id: settingsButton
            Layout.preferredHeight: parent.height * 0.1
            Layout.fillWidth: true
            color: "#494d64"
            radius: 16
            border {
                color: "#b8c0e0"
                width: 3
            }

            scale: mouseAreaSettings.pressed ? 0.98 : 1.0
            Behavior on scale {
                NumberAnimation {
                    duration: 100
                }
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 16

                Image {
                    source: "../Assets/setting.png"
                    Layout.preferredHeight: 32
                    Layout.preferredWidth: 32
                    fillMode: Image.PreserveAspectFit
                    smooth: true

                    rotation: mouseAreaPanel.containsMouse ? 180 : 0
                    Behavior on rotation {
                        NumberAnimation {
                            duration: 400
                            easing.type: Easing.InOutCubic
                        }
                    }
                }

                Text {
                    text: "Settings"
                    color: "#b8c0e0"
                    visible: mouseAreaPanel.containsMouse
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    font {
                        pixelSize: 20
                        family: "ComicShannsMono Nerd Font"
                        bold: false
                    }
                }
            }

            MouseArea {
                id: mouseAreaSettings
                anchors.fill: parent
                hoverEnabled: false
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    // Xử lý settings
                    indexChanged(1);
                }
            }
        }

        // Suspend Button - Chỉ có click, không có hover
        Rectangle {
            id: suspendButton
            Layout.preferredHeight: parent.height * 0.1
            Layout.fillWidth: true
            color: "#494d64"
            radius: 16
            border {
                color: "#b8c0e0"
                width: 3
            }

            scale: mouseAreaSuspend.pressed ? 0.98 : 1.0
            Behavior on scale {
                NumberAnimation {
                    duration: 100
                }
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 16

                Image {
                    source: "../Assets/sys-sleep.png"
                    Layout.preferredHeight: 32
                    Layout.preferredWidth: 32
                    fillMode: Image.PreserveAspectFit
                    smooth: true

                    opacity: 0.8
                }

                Text {
                    text: "Suspend"
                    color: "#b8c0e0"
                    visible: mouseAreaPanel.containsMouse
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    font {
                        pixelSize: 20
                        family: "ComicShannsMono Nerd Font"
                        bold: false
                    }
                }
            }

            MouseArea {
                id: mouseAreaSuspend
                anchors.fill: parent
                hoverEnabled: false
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    // Xử lý suspend
                    indexChanged(2);
                }
            }
        }

        // Reboot Button - Chỉ có click, không có hover
        Rectangle {
            id: rebootButton
            Layout.preferredHeight: parent.height * 0.1
            Layout.fillWidth: true
            color: "#494d64"
            radius: 16
            border {
                color: "#b8c0e0"
                width: 3
            }

            scale: mouseAreaReboot.pressed ? 0.98 : 1.0
            Behavior on scale {
                NumberAnimation {
                    duration: 100
                }
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 16

                Image {
                    source: "../Assets/sys-reboot.png"
                    Layout.preferredHeight: 32
                    Layout.preferredWidth: 32
                    fillMode: Image.PreserveAspectFit
                    smooth: true

                    rotation: mouseAreaPanel.containsMouse ? 360 : 0
                    Behavior on rotation {
                        NumberAnimation {
                            duration: 800
                            easing.type: Easing.InOutCubic
                        }
                    }
                }

                Text {
                    text: "Reboot"
                    color: "#b8c0e0"
                    visible: mouseAreaPanel.containsMouse
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    font {
                        pixelSize: 20
                        family: "ComicShannsMono Nerd Font"
                        bold: false
                    }
                }
            }

            MouseArea {
                id: mouseAreaReboot
                anchors.fill: parent
                hoverEnabled: false
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    // Xử lý reboot
                    indexChanged(3);
                }
            }
        }

        // Poweroff Button - Chỉ có click, không có hover
        Rectangle {
            id: poweroffButton
            Layout.preferredHeight: parent.height * 0.1
            Layout.fillWidth: true
            color: "#494d64"
            radius: 16
            border {
                color: "#b8c0e0"
                width: 3
            }

            scale: mouseAreaPoweroff.pressed ? 0.98 : 1.0
            Behavior on scale {
                NumberAnimation {
                    duration: 100
                }
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 16

                Image {
                    source: "../Assets/poweroff.png"
                    Layout.preferredHeight: 32
                    Layout.preferredWidth: 32
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                }

                Text {
                    text: "Poweroff"
                    color: "#b8c0e0"
                    visible: mouseAreaPanel.containsMouse
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    font {
                        pixelSize: 20
                        family: "ComicShannsMono Nerd Font"
                        bold: false
                    }
                }
            }

            MouseArea {
                id: mouseAreaPoweroff
                anchors.fill: parent
                hoverEnabled: false
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    // Xử lý poweroff
                    indexChanged(4);
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }

    // MouseArea để phát hiện hover trên toàn bộ leftPanel - SỬA QUAN TRỌNG
    MouseArea {
        id: mouseAreaPanel
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton  // QUAN TRỌNG: Không nhận sự kiện click nào

        // Chỉ nhận hover, không nhận click
        propagateComposedEvents: false
        z: -1  // Đặt xuống dưới để các MouseArea khác có thể nhận click

        // Sự kiện hover chỉ ảnh hưởng đến panel width và một số animation
        onEntered: {
            // console.log("Panel entered")
        }
        onExited: {
            // console.log("Panel exited")
        }
    }
}
