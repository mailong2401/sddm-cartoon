import QtQuick
import QtQuick.Layouts
import SddmComponents as SDDM

ColumnLayout {
    id: loginForm
    SDDM.TextConstants {
        id: textConstants
    }

    anchors.fill: parent
    spacing: parent.height * 0.05  // 1% của parent height

    // Animation properties
    property bool animationEnabled: true
    property real animationDuration: 800
    property real staggerDelay: 100

    // Opacity control for fade in
    opacity: 0

    // Timer để kích hoạt animation khi component được tạo
    Timer {
        id: startTimer
        interval: 100
        running: true
        onTriggered: {
            if (animationEnabled) {
                loginForm.startEntranceAnimation();
            } else {
                loginForm.opacity = 1;
            }
        }
    }

    // Hàm bắt đầu animation
    function startEntranceAnimation() {
        fadeInAnimation.start();
        clock.startAnimation(0);
        input.startAnimation(1);
        sessionButton.startAnimation(2);
        systemButtons.startAnimation(3);
    }

    // Fade in animation cho toàn bộ panel
    SequentialAnimation {
        id: fadeInAnimation
        NumberAnimation {
            target: loginForm
            property: "opacity"
            from: 0
            to: 1
            duration: animationDuration * 0.6
            easing.type: Easing.OutCubic
        }
    }

    Clock {
        id: clock
        Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
        Layout.preferredHeight: parent.height * 0.25
        Layout.fillWidth: true

        property bool animated: animationEnabled
        property real animationDuration: loginForm.animationDuration

        function startAnimation(delayIndex) {
            if (animated) {
                clockEntranceAnimation.start(delayIndex * loginForm.staggerDelay);
            }
        }

        SequentialAnimation {
            id: clockEntranceAnimation
            PauseAnimation {
                id: clockPause
                duration: 0
            }
            ParallelAnimation {
                NumberAnimation {
                    target: clock
                    property: "scale"
                    from: 0.8
                    to: 1.0
                    duration: animationDuration
                    easing.type: Easing.OutBack
                    easing.overshoot: 1.5
                }
                NumberAnimation {
                    target: clock
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: animationDuration * 0.7
                    easing.type: Easing.OutCubic
                }
            }
        }
    }

    Input {
        id: input
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        Layout.preferredHeight: parent.height * 0.15
        Layout.fillWidth: true
        Layout.topMargin: parent.height * 0.01

        property bool animated: animationEnabled
        property real animationDuration: loginForm.animationDuration

        function startAnimation(delayIndex) {
            if (animated) {
                inputEntranceAnimation.start(delayIndex * loginForm.staggerDelay);
            }
        }

        SequentialAnimation {
            id: inputEntranceAnimation
            PauseAnimation {
                id: inputPause
                duration: 0
            }
            ParallelAnimation {
                NumberAnimation {
                    target: input
                    property: "x"
                    from: input.width * 0.5
                    to: 0
                    duration: animationDuration
                    easing.type: Easing.OutBack
                    easing.overshoot: 1.2
                }
                NumberAnimation {
                    target: input
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: animationDuration * 0.8
                    easing.type: Easing.OutCubic
                }
            }
        }
    }


    SystemButtons {
        id: systemButtons
        Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
        Layout.preferredHeight: parent.height * 0.12  // 12% của parent height
        Layout.maximumHeight: parent.height * 0.15
        Layout.fillWidth: true
        Layout.bottomMargin: parent.height * 0.01     // 1% của parent height
        exposedSession: sessionButton.exposeSession

        property bool animated: animationEnabled
        property real animationDuration: loginForm.animationDuration

        function startAnimation(delayIndex) {
            if (animated) {
                systemButtonsEntranceAnimation.start(delayIndex * loginForm.staggerDelay);
            }
        }

        SequentialAnimation {
            id: systemButtonsEntranceAnimation
            PauseAnimation {
                id: systemButtonsPause
                duration: 0
            }
            ParallelAnimation {
                NumberAnimation {
                    target: systemButtons
                    property: "y"
                    from: systemButtons.height
                    to: 0
                    duration: animationDuration
                    easing.type: Easing.OutBack
                    easing.overshoot: 1.3
                }
                NumberAnimation {
                    target: systemButtons
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: animationDuration * 0.7
                    easing.type: Easing.OutCubic
                }
            }
        }
    }

    // Thêm bottom spacer nhỏ
    Item {
        id: bottomSpacer
        Layout.preferredHeight: parent.height * 0.01  // 1% của parent height
        Layout.fillWidth: true
    }

    // Animation khi component bị ẩn/remove
    function exitAnimation() {
        exitAnim.start();
    }

    SequentialAnimation {
        id: exitAnim
        ParallelAnimation {
            NumberAnimation {
                target: loginForm
                property: "opacity"
                from: 1
                to: 0
                duration: animationDuration * 0.5
                easing.type: Easing.InCubic
            }
            NumberAnimation {
                target: loginForm
                property: "x"
                from: 0
                to: loginForm.width * 0.3
                duration: animationDuration * 0.5
                easing.type: Easing.InCubic
            }
        }
    }
}
