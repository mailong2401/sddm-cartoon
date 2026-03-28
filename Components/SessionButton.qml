import QtQuick
import QtQuick.Controls

Item {
    id: sessionButton

    height: 40
    width: 200

    property var selectedSession: selectSession.currentIndex
    property string textConstantSession
    property int loginButtonWidth
    property ComboBox exposeSession: selectSession
    property bool animationEnabled: true

    // Animation properties
    opacity: 0
    scale: 0.9

    Component.onCompleted: {
        if (animationEnabled) {
            sessionEntranceAnimation.start();
        } else {
            opacity = 1;
            scale = 1;
        }
    }

    ParallelAnimation {
        id: sessionEntranceAnimation
        NumberAnimation {
            target: sessionButton
            property: "opacity"
            from: 0
            to: 1
            duration: 600
            easing.type: Easing.OutCubic
        }
        NumberAnimation {
            target: sessionButton
            property: "scale"
            from: 0.9
            to: 1
            duration: 600
            easing.type: Easing.OutBack
            easing.overshoot: 1.2
        }
    }

    ComboBox {
        id: selectSession

        anchors.fill: parent
        anchors.margins: 2

        hoverEnabled: true
        model: sessionModel
        currentIndex: model.lastIndex
        textRole: "name"

        // Custom style for Catppuccin theme
        property color normalColor: "#494d64"
        property color hoverColor: "#363a4f"
        property color borderColor: "#b8c0e0"
        property color textColor: "#cad3f5"
        property color hoverTextColor: "#b8c0e0"

        Keys.onPressed: function (event) {
            if ((event.key == Qt.Key_Left || event.key == Qt.Key_Right) && !popup.opened) {
                popup.open();
            }
        }

        delegate: ItemDelegate {
            width: popupHandler.width - 20
            height: 35

            contentItem: Text {
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                leftPadding: 10

                text: model.name
                font.pixelSize: 14
                font.family: "ComicShannsMono Nerd Font"
                color: selectSession.highlightedIndex === index ? "#24273a" : "#cad3f5"
            }

            background: Rectangle {
                radius: 6
                color: selectSession.highlightedIndex === index ? "#8aadf4" : "transparent"

                Behavior on color {
                    ColorAnimation {
                        duration: 150
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.scale = 1.02;
                    if (selectSession.highlightedIndex !== index) {
                        parent.background.color = "#363a4f";
                    }
                }
                onExited: {
                    parent.scale = 1.0;
                    if (selectSession.highlightedIndex !== index) {
                        parent.background.color = "transparent";
                    }
                }
            }
        }

        indicator: Canvas {
            id: dropdownArrow
            x: selectSession.width - width - 10
            y: selectSession.topPadding + (selectSession.availableHeight - height) / 2
            width: 12
            height: 8

            onPaint: {
                var ctx = getContext("2d");
                ctx.reset();
                ctx.strokeStyle = selectSession.popup.visible ? "#8aadf4" : "#b8c0e0";
                ctx.lineWidth = 2;
                ctx.beginPath();
                ctx.moveTo(0, 0);
                ctx.lineTo(width / 2, height);
                ctx.lineTo(width, 0);
                ctx.stroke();
            }

            Behavior on opacity {
                NumberAnimation {
                    duration: 150
                }
            }
        }

        contentItem: Text {
            id: displayedItem

            anchors.fill: parent
            anchors.leftMargin: 15
            verticalAlignment: Text.AlignVCenter

            text: selectSession.currentText
            color: selectSession.popup.visible ? selectSession.hoverTextColor : selectSession.textColor
            font.pixelSize: 14
            font.family: "ComicShannsMono Nerd Font"

            elide: Text.ElideRight
        }

        background: Rectangle {
            id: comboBackground
            radius: 10
            color: selectSession.popup.visible ? selectSession.hoverColor : selectSession.normalColor
            border {
                color: selectSession.popup.visible ? "#8aadf4" : selectSession.borderColor
                width: 2
            }

            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
            Behavior on border.color {
                ColorAnimation {
                    duration: 200
                }
            }

            // Hover effect
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    if (!selectSession.popup.visible) {
                        comboBackground.color = selectSession.hoverColor;
                        comboBackground.border.color = "#8aadf4";
                        dropdownArrow.opacity = 0.7;
                    }
                }
                onExited: {
                    if (!selectSession.popup.visible) {
                        comboBackground.color = selectSession.normalColor;
                        comboBackground.border.color = selectSession.borderColor;
                        dropdownArrow.opacity = 1;
                    }
                }
            }
        }

        popup: Popup {
            id: popupHandler

            y: selectSession.height - 1
            width: selectSession.width
            implicitHeight: Math.min(contentItem.implicitHeight, 300)
            padding: 10

            contentItem: ListView {
                clip: true
                implicitHeight: contentHeight
                model: selectSession.popup.visible ? selectSession.delegateModel : null
                currentIndex: selectSession.highlightedIndex

                ScrollIndicator.vertical: ScrollIndicator {
                    parent: popupHandler.contentItem
                    anchors {
                        top: parent.top
                        right: parent.right
                        bottom: parent.bottom
                    }
                }
            }

            background: Rectangle {
                radius: 10
                color: "#363a4f"
                border {
                    color: "#8aadf4"
                    width: 2
                }

                // Alternative shadow effect without DropShadow
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: -2
                    radius: parent.radius + 2
                    color: "transparent"
                    border {
                        color: "#1e2030"
                        width: 2
                    }
                    opacity: 0.3
                    z: -1
                }
            }

            enter: Transition {
                NumberAnimation {
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 200
                }
                NumberAnimation {
                    property: "scale"
                    from: 0.95
                    to: 1
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }

            exit: Transition {
                NumberAnimation {
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: 150
                }
            }

            onOpenedChanged: {
                dropdownArrow.requestPaint();
            }
            
            // Khi popup đóng, reset màu nền của combo box
            onClosed: {
                comboBackground.color = selectSession.normalColor;
                comboBackground.border.color = selectSession.borderColor;
            }
        }
    }
}
