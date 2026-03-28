import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ColumnLayout {
    id: settingForm
    anchors.fill: parent
    anchors.margins: 20
    spacing: 15

    property bool animationEnabled: true
    property real animationDuration: 600
    property bool showAdvanced: false

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
            target: settingForm
            property: "opacity"
            from: 0
            to: 1
            duration: animationDuration * 0.6
            easing.type: Easing.OutCubic
        }
    }

    // Tiêu đề
    Text {
        id: titleText
        text: "⚙️ Settings"
        color: "#b8c0e0"
        font {
            pixelSize: 28
            family: "ComicShannsMono Nerd Font"
            bold: true
        }
        Layout.alignment: Qt.AlignHCenter

        // Animation slide từ trên xuống
        y: animationEnabled ? -50 : 0
        opacity: 0

        Component.onCompleted: {
            if (animationEnabled) {
                titleAnimation.start();
            } else {
                y = 0;
                opacity = 1;
            }
        }

        ParallelAnimation {
            id: titleAnimation
            NumberAnimation {
                target: titleText
                property: "y"
                from: -50
                to: 0
                duration: animationDuration
                easing.type: Easing.OutBack
                easing.overshoot: 1.5
            }
            NumberAnimation {
                target: titleText
                property: "opacity"
                from: 0
                to: 1
                duration: animationDuration * 0.7
                easing.type: Easing.OutCubic
            }
        }
    }

    // ScrollView cho các setting
    ScrollView {
        id: scrollView
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.topMargin: 10
        clip: true

        // Animation cho scroll view
        opacity: 0
        y: animationEnabled ? 30 : 0

        Component.onCompleted: {
            if (animationEnabled) {
                scrollAnimation.start();
            } else {
                opacity = 1;
                y = 0;
            }
        }

        ParallelAnimation {
            id: scrollAnimation
            NumberAnimation {
                target: scrollView
                property: "y"
                from: 30
                to: 0
                duration: animationDuration
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                target: scrollView
                property: "opacity"
                from: 0
                to: 1
                duration: animationDuration * 0.8
                easing.type: Easing.OutCubic
            }
        }

        ColumnLayout {
            width: scrollView.width
            spacing: 15

            // Section: Theme Settings
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                color: "#363a4f"
                radius: 10
                border {
                    color: "#b8c0e0"
                    width: 1
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 5

                    Text {
                        text: "🎨 Theme"
                        color: "#b8c0e0"
                        font {
                            pixelSize: 16
                            family: "ComicShannsMono Nerd Font"
                            bold: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        // Theme selection buttons
                        Repeater {
                            model: [
                                {
                                    name: "Dark",
                                    color: "#24273a"
                                },
                                {
                                    name: "Light",
                                    color: "#eff1f5"
                                },
                                {
                                    name: "Purple",
                                    color: "#363a4f"
                                }
                            ]

                            Rectangle {
                                Layout.preferredWidth: 70
                                Layout.preferredHeight: 30
                                radius: 6
                                color: modelData.color
                                border {
                                    color: index === 0 ? "#8aadf4" : "transparent"
                                    width: 2
                                }

                                Text {
                                    text: modelData.name
                                    color: index === 1 ? "#24273a" : "#cad3f5"
                                    font {
                                        pixelSize: 12
                                        family: "ComicShannsMono Nerd Font"
                                    }
                                    anchors.centerIn: parent
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        // Change theme logic here
                                        console.log("Theme changed to:", modelData.name);
                                    }
                                    onEntered: parent.scale = 1.05
                                    onExited: parent.scale = 1.0
                                }

                                Behavior on scale {
                                    NumberAnimation {
                                        duration: 150
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // Section: Display Settings
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                color: "#363a4f"
                radius: 10
                border {
                    color: "#b8c0e0"
                    width: 1
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 8

                    Text {
                        text: "🖥️ Display"
                        color: "#b8c0e0"
                        font {
                            pixelSize: 16
                            family: "ComicShannsMono Nerd Font"
                            bold: true
                        }
                    }

                    // Brightness control
                    RowLayout {
                        spacing: 10
                        Layout.fillWidth: true

                        Text {
                            text: "Brightness:"
                            color: "#cad3f5"
                            font {
                                pixelSize: 12
                                family: "ComicShannsMono Nerd Font"
                            }
                        }

                        Slider {
                            id: brightnessSlider
                            Layout.fillWidth: true
                            from: 20
                            to: 100
                            value: 80
                            background: Rectangle {
                                x: brightnessSlider.leftPadding
                                y: brightnessSlider.topPadding + brightnessSlider.availableHeight / 2 - height / 2
                                implicitWidth: 200
                                implicitHeight: 4
                                width: brightnessSlider.availableWidth
                                height: implicitHeight
                                radius: 2
                                color: "#494d64"

                                Rectangle {
                                    width: brightnessSlider.visualPosition * parent.width
                                    height: parent.height
                                    color: "#8aadf4"
                                    radius: 2
                                }
                            }
                            handle: Rectangle {
                                x: brightnessSlider.leftPadding + brightnessSlider.visualPosition * (brightnessSlider.availableWidth - width)
                                y: brightnessSlider.topPadding + brightnessSlider.availableHeight / 2 - height / 2
                                implicitWidth: 16
                                implicitHeight: 16
                                radius: 8
                                color: brightnessSlider.pressed ? "#cad3f5" : "#8aadf4"
                                border.color: "#b8c0e0"
                            }
                        }

                        Text {
                            text: Math.round(brightnessSlider.value) + "%"
                            color: "#cad3f5"
                            font {
                                pixelSize: 12
                                family: "ComicShannsMono Nerd Font"
                                bold: true
                            }
                        }
                    }

                    // Screen timeout
                    RowLayout {
                        spacing: 10
                        Layout.fillWidth: true

                        Text {
                            text: "Screen Timeout:"
                            color: "#cad3f5"
                            font {
                                pixelSize: 12
                                family: "ComicShannsMono Nerd Font"
                            }
                        }

                        ComboBox {
                            id: timeoutCombo
                            Layout.fillWidth: true
                            model: ["30 seconds", "1 minute", "2 minutes", "5 minutes", "10 minutes", "Never"]
                            currentIndex: 2
                            background: Rectangle {
                                color: "#494d64"
                                radius: 6
                                border {
                                    color: "#b8c0e0"
                                    width: 1
                                }
                            }
                            contentItem: Text {
                                text: timeoutCombo.currentText
                                color: "#cad3f5"
                                font {
                                    pixelSize: 12
                                    family: "ComicShannsMono Nerd Font"
                                }
                                verticalAlignment: Text.AlignVCenter
                                leftPadding: 8
                            }
                            popup: Popup {
                                y: timeoutCombo.height
                                width: timeoutCombo.width
                                implicitHeight: contentItem.implicitHeight
                                padding: 1

                                contentItem: ListView {
                                    clip: true
                                    implicitHeight: contentHeight
                                    model: timeoutCombo.popup.visible ? timeoutCombo.delegateModel : null
                                    currentIndex: timeoutCombo.highlightedIndex
                                }

                                background: Rectangle {
                                    color: "#363a4f"
                                    border.color: "#b8c0e0"
                                    radius: 6
                                }
                            }
                        }
                    }
                }
            }

            // Section: Language Settings
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                color: "#363a4f"
                radius: 10
                border {
                    color: "#b8c0e0"
                    width: 1
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 8

                    Text {
                        text: "🌐 Language"
                        color: "#b8c0e0"
                        font {
                            pixelSize: 16
                            family: "ComicShannsMono Nerd Font"
                            bold: true
                        }
                    }

                    RowLayout {
                        spacing: 10
                        Layout.fillWidth: true

                        ComboBox {
                            id: languageCombo
                            Layout.fillWidth: true
                            model: ["English (US)", "Vietnamese", "Japanese", "Spanish", "French", "German", "Chinese"]
                            currentIndex: 0
                            background: Rectangle {
                                color: "#494d64"
                                radius: 6
                                border {
                                    color: "#b8c0e0"
                                    width: 1
                                }
                            }
                            contentItem: Text {
                                text: languageCombo.currentText
                                color: "#cad3f5"
                                font {
                                    pixelSize: 12
                                    family: "ComicShannsMono Nerd Font"
                                }
                                verticalAlignment: Text.AlignVCenter
                                leftPadding: 8
                            }
                            popup: Popup {
                                y: languageCombo.height
                                width: languageCombo.width
                                implicitHeight: contentItem.implicitHeight
                                padding: 1

                                contentItem: ListView {
                                    clip: true
                                    implicitHeight: contentHeight
                                    model: languageCombo.popup.visible ? languageCombo.delegateModel : null
                                    currentIndex: languageCombo.highlightedIndex
                                }

                                background: Rectangle {
                                    color: "#363a4f"
                                    border.color: "#b8c0e0"
                                    radius: 6
                                }
                            }
                        }
                    }
                }
            }

            // Section: Accessibility
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                color: "#363a4f"
                radius: 10
                border {
                    color: "#b8c0e0"
                    width: 1
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 8

                    Text {
                        text: "♿ Accessibility"
                        color: "#b8c0e0"
                        font {
                            pixelSize: 16
                            family: "ComicShannsMono Nerd Font"
                            bold: true
                        }
                    }

                    // High contrast toggle
                    RowLayout {
                        spacing: 10
                        Layout.fillWidth: true

                        Text {
                            text: "High Contrast:"
                            color: "#cad3f5"
                            font {
                                pixelSize: 12
                                family: "ComicShannsMono Nerd Font"
                            }
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        Switch {
                            id: contrastSwitch
                            checked: false
                            indicator: Rectangle {
                                implicitWidth: 48
                                implicitHeight: 24
                                radius: 12
                                color: contrastSwitch.checked ? "#8aadf4" : "#494d64"
                                border.color: "#b8c0e0"

                                Rectangle {
                                    x: contrastSwitch.checked ? parent.width - width - 2 : 2
                                    y: 2
                                    width: 20
                                    height: 20
                                    radius: 10
                                    color: contrastSwitch.checked ? "#24273a" : "#cad3f5"
                                    Behavior on x {
                                        NumberAnimation {
                                            duration: 150
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // Large text toggle
                    RowLayout {
                        spacing: 10
                        Layout.fillWidth: true

                        Text {
                            text: "Large Text:"
                            color: "#cad3f5"
                            font {
                                pixelSize: 12
                                family: "ComicShannsMono Nerd Font"
                            }
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        Switch {
                            id: largeTextSwitch
                            checked: false
                            indicator: Rectangle {
                                implicitWidth: 48
                                implicitHeight: 24
                                radius: 12
                                color: largeTextSwitch.checked ? "#8aadf4" : "#494d64"
                                border.color: "#b8c0e0"

                                Rectangle {
                                    x: largeTextSwitch.checked ? parent.width - width - 2 : 2
                                    y: 2
                                    width: 20
                                    height: 20
                                    radius: 10
                                    color: largeTextSwitch.checked ? "#24273a" : "#cad3f5"
                                    Behavior on x {
                                        NumberAnimation {
                                            duration: 150
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // Advanced settings toggle
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                color: "transparent"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        showAdvanced = !showAdvanced;
                        advancedSettings.opacity = showAdvanced ? 1 : 0;
                        advancedSettings.height = showAdvanced ? 100 : 0;
                        arrowIcon.rotation = showAdvanced ? 90 : 0;
                    }
                    onEntered: parent.border.color = "#8aadf4"
                    onExited: parent.border.color = "transparent"
                }

                RowLayout {
                    anchors.fill: parent
                    spacing: 10

                    Text {
                        text: "⚙️ Advanced Settings"
                        color: "#8aadf4"
                        font {
                            pixelSize: 14
                            family: "ComicShannsMono Nerd Font"
                            bold: true
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    Image {
                        id: arrowIcon
                        source: "../Assets/arrow-right.png"
                        Layout.preferredWidth: 16
                        Layout.preferredHeight: 16
                        fillMode: Image.PreserveAspectFit
                        smooth: true

                        Behavior on rotation {
                            NumberAnimation {
                                duration: 300
                                easing.type: Easing.OutCubic
                            }
                        }
                    }
                }
            }

            // Advanced Settings (collapsible)
            Rectangle {
                id: advancedSettings
                Layout.fillWidth: true
                Layout.preferredHeight: 0
                color: "#363a4f"
                radius: 10
                opacity: 0
                clip: true

                Behavior on height {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }
                Behavior on opacity {
                    NumberAnimation {
                        duration: 200
                    }
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 8
                    visible: showAdvanced

                    // Numlock on login
                    RowLayout {
                        spacing: 10
                        Layout.fillWidth: true

                        Text {
                            text: "NumLock on login:"
                            color: "#cad3f5"
                            font {
                                pixelSize: 12
                                family: "ComicShannsMono Nerd Font"
                            }
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        Switch {
                            id: numlockSwitch
                            checked: true
                            indicator: Rectangle {
                                implicitWidth: 48
                                implicitHeight: 24
                                radius: 12
                                color: numlockSwitch.checked ? "#8aadf4" : "#494d64"
                                border.color: "#b8c0e0"

                                Rectangle {
                                    x: numlockSwitch.checked ? parent.width - width - 2 : 2
                                    y: 2
                                    width: 20
                                    height: 20
                                    radius: 10
                                    color: numlockSwitch.checked ? "#24273a" : "#cad3f5"
                                    Behavior on x {
                                        NumberAnimation {
                                            duration: 150
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // Hide users
                    RowLayout {
                        spacing: 10
                        Layout.fillWidth: true

                        Text {
                            text: "Hide user list:"
                            color: "#cad3f5"
                            font {
                                pixelSize: 12
                                family: "ComicShannsMono Nerd Font"
                            }
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        Switch {
                            id: hideUsersSwitch
                            checked: false
                            indicator: Rectangle {
                                implicitWidth: 48
                                implicitHeight: 24
                                radius: 12
                                color: hideUsersSwitch.checked ? "#8aadf4" : "#494d64"
                                border.color: "#b8c0e0"

                                Rectangle {
                                    x: hideUsersSwitch.checked ? parent.width - width - 2 : 2
                                    y: 2
                                    width: 20
                                    height: 20
                                    radius: 10
                                    color: hideUsersSwitch.checked ? "#24273a" : "#cad3f5"
                                    Behavior on x {
                                        NumberAnimation {
                                            duration: 150
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // Nút điều khiển
    RowLayout {
        Layout.alignment: Qt.AlignHCenter
        Layout.topMargin: 10
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

        // Nút Reset
        Rectangle {
            id: resetButton
            Layout.preferredWidth: 120
            Layout.preferredHeight: 45
            color: "#494d64"
            radius: 10
            border {
                color: "#b8c0e0"
                width: 2
            }

            scale: resetMouseArea.pressed ? 0.95 : 1.0

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
                text: "Reset"
                color: "#b8c0e0"
                font {
                    pixelSize: 16
                    family: "ComicShannsMono Nerd Font"
                    bold: false
                }
                anchors.centerIn: parent
            }

            MouseArea {
                id: resetMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    // Reset all settings
                    brightnessSlider.value = 80;
                    timeoutCombo.currentIndex = 2;
                    languageCombo.currentIndex = 0;
                    contrastSwitch.checked = false;
                    largeTextSwitch.checked = false;
                    numlockSwitch.checked = true;
                    hideUsersSwitch.checked = false;

                    // Show reset confirmation
                    resetAnimation.start();
                }
                onEntered: parent.border.color = "#ed8796"
                onExited: parent.border.color = "#b8c0e0"
            }
        }

        // Nút Apply
        Rectangle {
            id: applyButton
            Layout.preferredWidth: 120
            Layout.preferredHeight: 45
            color: "#8aadf4"
            radius: 10
            border {
                color: "#b8c0e0"
                width: 2
            }

            scale: applyMouseArea.pressed ? 0.95 : 1.0

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
                text: "Apply"
                color: "#24273a"
                font {
                    pixelSize: 16
                    family: "ComicShannsMono Nerd Font"
                    bold: true
                }
                anchors.centerIn: parent
            }

            MouseArea {
                id: applyMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    // Apply settings logic here
                    console.log("Settings applied");
                    applyAnimation.start();
                    formContainer.indexSelect = 0;  // Quay lại login form
                }
                onEntered: parent.border.color = "#24273a"
                onExited: parent.border.color = "#b8c0e0"
            }
        }
    }

    // Animation khi nhấn reset
    SequentialAnimation {
        id: resetAnimation
        ParallelAnimation {
            NumberAnimation {
                target: resetButton
                property: "scale"
                from: 1.0
                to: 0.9
                duration: 100
            }
            ColorAnimation {
                target: resetButton
                property: "color"
                from: "#494d64"
                to: "#ed8796"
                duration: 100
            }
        }
        ParallelAnimation {
            NumberAnimation {
                target: resetButton
                property: "scale"
                from: 0.9
                to: 1.0
                duration: 200
            }
            ColorAnimation {
                target: resetButton
                property: "color"
                from: "#ed8796"
                to: "#494d64"
                duration: 200
            }
        }
    }

    // Animation khi nhấn apply
    SequentialAnimation {
        id: applyAnimation
        ParallelAnimation {
            NumberAnimation {
                target: applyButton
                property: "scale"
                from: 1.0
                to: 0.9
                duration: 100
            }
            ColorAnimation {
                target: applyButton
                property: "color"
                from: "#8aadf4"
                to: "#a6da95"
                duration: 100
            }
        }
        ParallelAnimation {
            NumberAnimation {
                target: applyButton
                property: "scale"
                from: 0.9
                to: 1.0
                duration: 200
            }
            ColorAnimation {
                target: applyButton
                property: "color"
                from: "#a6da95"
                to: "#8aadf4"
                duration: 200
            }
        }
    }
}
