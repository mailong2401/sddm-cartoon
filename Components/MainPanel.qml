import QtQuick
import QtQuick.Layouts

Rectangle {
    id: formContainer
    color: "#24273a"
    height: parent.height / 2
    width: parent.width / 2.5
    radius: 32
    border {
        color: "#b8c0e0"
        width: 3
    }

    property var indexSelect: 0

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Thanh bar
        TitleBar {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.1
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0

            // Bên trái
            LeftPanel {
                onIndexChanged: function (index) {
                    formContainer.indexSelect = index;
                }
            }

            // Bên phải - Sử dụng StackLayout và Loader
            StackLayout {
                id: rightStack
                Layout.fillWidth: true
                Layout.fillHeight: true
                currentIndex: formContainer.indexSelect

                Loader {
                    id: rightPanelLoader
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    active: rightStack.currentIndex === 0
                    source: "LoginForm.qml"
                    onLoaded: {
                        item.visible = Qt.binding(function () {
                            return rightStack.currentIndex === 0;
                        });
                    }
                }

                Loader {
                    id: loginFormLoader
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    active: rightStack.currentIndex === 1
                    source: "SettingsForm.qml"
                    onLoaded: {
                        item.visible = Qt.binding(function () {
                            return rightStack.currentIndex === 1;
                        });
                    }
                }

                // Thêm Loader cho SleepForm
                Loader {
                    id: sleepFormLoader
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    active: rightStack.currentIndex === 2
                    source: "SleepForm.qml"
                    onLoaded: {
                        item.visible = Qt.binding(function () {
                            return rightStack.currentIndex === 2;
                        });
                    }
                }

                // Thêm Loader cho RebootForm
                Loader {
                    id: rebootFormLoader
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    active: rightStack.currentIndex === 3
                    source: "RebootForm.qml"
                    onLoaded: {
                        item.visible = Qt.binding(function () {
                            return rightStack.currentIndex === 3;
                        });
                    }
                }

                // Thêm Loader cho ShutdownForm
                Loader {
                    id: shutdownFormLoader
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    active: rightStack.currentIndex === 4
                    source: "ShutdownForm.qml"
                    onLoaded: {
                        item.visible = Qt.binding(function () {
                            return rightStack.currentIndex === 4;
                        });
                    }
                }
            }
        }
    }
}
