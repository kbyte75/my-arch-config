import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import SddmComponents 2.0 as SDDM

Column {
    id: inputContainer

    property ComboBox exposeSession: sessionSelect.exposeSession
    property bool failed

    Layout.fillWidth: true

    // Error Message field
    Item {
        id: errorMessageField

        height: root.font.pointSize * 2
        width: parent.width / 2
        anchors.horizontalCenter: parent.horizontalCenter

        Label {
            id: errorMessage

            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            text: failed ? config.TranslateLoginFailedWarning || textConstants.loginFailed + "!" : keyboard.capsLock ? config.TranslateCapslockWarning || textConstants.capslockWarning : null
            font.pointSize: root.font.pointSize * 1.2
            font.capitalization: Font.AllUppercase
            color: config.WarningColor
            opacity: 0
            states: [
                State {
                    name: "fail"
                    when: failed

                    PropertyChanges {
                        target: errorMessage
                        opacity: 1
                    }

                },
                State {
                    name: "capslock"
                    when: keyboard.capsLock

                    PropertyChanges {
                        target: errorMessage
                        opacity: 1
                    }

                }
            ]
            transitions: [
                Transition {
                    PropertyAnimation {
                        properties: "opacity"
                        duration: 100
                    }

                }
            ]
        }

    }

    // empty space
    Item {
        height: 10
        width: parent.width
    }

    // Username field
    Item {
        id: usernameField

        height: root.font.pointSize * 4.5
        width: parent.width / 2
        anchors.horizontalCenter: parent.horizontalCenter

        ComboBox {
            id: selectUser

            property var popkey: config.RightToLeftLayout == "true" ? Qt.Key_Right : Qt.Key_Left

            width: parent.height
            height: parent.height
            anchors.left: parent.left
            z: 2
            model: userModel
            currentIndex: model.lastIndex
            textRole: "name"
            hoverEnabled: true
            onActivated: {
                username.text = currentText;
            }
            Keys.onPressed: function(event) {
                if (event.key == Qt.Key_Down && !popup.opened)
                    username.forceActiveFocus();

                if ((event.key == Qt.Key_Up || event.key == popkey) && !popup.opened)
                    popup.open();

            }
            KeyNavigation.down: username
            KeyNavigation.right: username
            states: [
                State {
                    name: "pressed"
                    when: selectUser.down

                    PropertyChanges {
                        target: usernameIcon
                        icon.color: Qt.lighter(config.HoverUserIconColor, 1.1)
                    }

                },
                State {
                    name: "hovered"
                    when: selectUser.hovered

                    PropertyChanges {
                        target: usernameIcon
                        icon.color: Qt.lighter(config.HoverUserIconColor, 1.2)
                    }

                },
                State {
                    name: "focused"
                    when: selectUser.activeFocus

                    PropertyChanges {
                        target: usernameIcon
                        icon.color: config.HoverUserIconColor
                    }

                }
            ]
            transitions: [
                Transition {
                    PropertyAnimation {
                        properties: "color, border.color, icon.color"
                        duration: 200
                    }

                }
            ]

            delegate: ItemDelegate {
                width: popupHandler.width - 20
                anchors.horizontalCenter: popupHandler.horizontalCenter

                contentItem: Text {
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: model.name
                    font.pointSize: root.font.pointSize * 0.8
                    font.capitalization: Font.AllLowercase
                    font.family: root.font.family
                    color: config.DropdownTextColor
                }

                background: Rectangle {
                    color: selectUser.highlightedIndex === index ? config.DropdownSelectedBackgroundColor : "transparent"
                    opacity: selectUser.highlightedIndex === index ? 0.6 : 0
                }

            }

            indicator: Button {
                id: usernameIcon

                width: selectUser.height * 1
                height: parent.height
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: selectUser.height * 0
                icon.height: parent.height * 0.25
                icon.width: parent.height * 0.25
                enabled: false
                icon.color: config.UserIconColor
                icon.source: Qt.resolvedUrl("../Assets/user.svg")

                background: Rectangle {
                    color: "transparent"
                    border.color: "transparent"
                }

            }

            background: Rectangle {
                color: "transparent"
                border.color: "transparent"
            }

            popup: Popup {
                id: popupHandler

                implicitHeight: contentItem.implicitHeight
                width: usernameField.width
                y: parent.height - username.height / 3
                x: config.RightToLeftLayout == "true" ? -loginButton.width + selectUser.width : 0
                rightMargin: config.RightToLeftLayout == "true" ? root.padding + usernameField.width / 2 : undefined
                padding: 10

                contentItem: ListView {
                    implicitHeight: contentHeight + 20
                    clip: true
                    model: selectUser.popup.visible ? selectUser.delegateModel : null
                    currentIndex: selectUser.highlightedIndex

                    ScrollIndicator.vertical: ScrollIndicator {
                    }

                }

                background: Rectangle {
                    radius: config.RoundCorners / 8
                    color: config.DropdownBackgroundColor
                    layer.enabled: true
                    opacity: 0.4
                }

                enter: Transition {
                    NumberAnimation {
                        property: "opacity"
                        from: 0
                        to: 1
                    }

                }

            }

        }

        TextField {
            id: username

            anchors.centerIn: parent
            height: root.font.pointSize * 3
            width: parent.width
            horizontalAlignment: TextInput.AlignHCenter
            z: 1
            text: config.ForceLastUser == "true" ? selectUser.currentText : null
            color: config.LoginFieldTextColor
            font.bold: true
            font.capitalization: config.AllowUppercaseLettersInUsernames == "false" ? Font.AllLowercase : Font.MixedCase
            placeholderText: config.TranslatePlaceholderUsername || textConstants.userName
            placeholderTextColor: config.PlaceholderTextColor
            selectByMouse: true
            renderType: Text.QtRendering
            onFocusChanged: {
                if (focus)
                    selectAll();

            }
            onAccepted: config.AllowUppercaseLettersInUsernames == "false" ? sddm.login(username.text.toLowerCase(), password.text, sessionSelect.selectedSession) : sddm.login(username.text, password.text, sessionSelect.selectedSession)
            KeyNavigation.down: passwordIcon
            states: [
                State {
                    name: "focused"
                    when: username.activeFocus

                    PropertyChanges {
                        target: username.background
                        border.color: config.HighlightBorderColor
                    }

                    PropertyChanges {
                        target: username
                        color: Qt.lighter(config.LoginFieldTextColor, 1.15)
                    }

                }
            ]

            background: Rectangle {
                color: config.LoginFieldBackgroundColor
                opacity: 0.2
                border.color: "transparent"
                border.width: parent.activeFocus ? 2 : 1
                radius: config.RoundCorners || 0
            }

        }

    }

    // Password field
    Item {
        id: passwordField

        height: root.font.pointSize * 4.5
        width: parent.width / 2
        anchors.horizontalCenter: parent.horizontalCenter
        states: [
            State {
                name: "focused"
                when: password.activeFocus

                PropertyChanges {
                    target: password.background
                    border.color: config.HighlightBorderColor
                }

                PropertyChanges {
                    target: password
                    color: Qt.lighter(config.LoginFieldTextColor, 1.15)
                }

            }
        ]
        transitions: [
            Transition {
                PropertyAnimation {
                    properties: "color, border.color"
                    duration: 200
                }

            }
        ]

        Button {
            id: passwordIcon

            height: parent.height
            width: selectUser.height * 1
            anchors.left: parent.left
            anchors.leftMargin: selectUser.height * 0
            anchors.verticalCenter: parent.verticalCenter
            z: 2
            icon.height: parent.height * 0.25
            icon.width: parent.height * 0.25
            icon.source: Qt.resolvedUrl("../Assets/key.svg")
            icon.color: config.PasswordIconColor
            KeyNavigation.down: password

            background: Rectangle {
                color: "transparent"
                border.color: "transparent"
            }

        }

        TextField {
            id: password

            height: root.font.pointSize * 3
            width: parent.width
            anchors.centerIn: parent
            horizontalAlignment: TextInput.AlignHCenter
            font.bold: true
            color: config.PasswordFieldTextColor
            focus: config.PasswordFocus == "true" ? true : false
            echoMode: passwordIcon.checked ? TextInput.Normal : TextInput.Password
            placeholderText: "your password"
            placeholderTextColor: config.PlaceholderTextColor
            passwordCharacter: "*"
            passwordMaskDelay: config.HideCompletePassword == "true" ? undefined : 1000
            renderType: Text.QtRendering
            selectByMouse: true
            onAccepted: config.AllowUppercaseLettersInUsernames == "false" ? sddm.login(username.text.toLowerCase(), password.text, sessionSelect.selectedSession) : sddm.login(username.text, password.text, sessionSelect.selectedSession)
            KeyNavigation.down: loginButton

            background: Rectangle {
                color: config.PasswordFieldBackgroundColor
                opacity: 0.2
                border.color: "transparent"
                border.width: parent.activeFocus ? 2 : 1
                radius: config.RoundCorners || 0
            }

        }

    }

    // empty space
    Item {
        height: 15
        width: parent.width
    }

    Item {
        id: login

        height: 40
        width: parent.width / 2
        anchors.horizontalCenter: parent.horizontalCenter
        visible: true

        Button {
            id: loginButton

            height: root.font.pointSize * 3
            implicitWidth: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "Login"
            enabled: config.AllowEmptyPassword == "true" || (username.text != "" && password.text != "")
            hoverEnabled: true
            onClicked: config.AllowUppercaseLettersInUsernames == "false" ? sddm.login(username.text.toLowerCase(), password.text, sessionSelect.selectedSession) : sddm.login(username.text, password.text, sessionSelect.selectedSession)
            Keys.onReturnPressed: clicked()
            Keys.onEnterPressed: clicked()
            KeyNavigation.down: config.HideSystemButtons == "true" ? virtualKeyboard : systemButtons.children[0]
            states: [
                State {
                    name: "pressed"
                    when: loginButton.down

                    PropertyChanges {
                        target: loginButton.contentItem
                    }

                },
                State {
                    name: "hovered"
                    when: loginButton.hovered

                    PropertyChanges {
                        target: buttonBackground
                        color: Qt.lighter(config.LoginButtonBackgroundColor, 1.15)
                        opacity: 1
                    }

                    PropertyChanges {
                        target: loginButton.contentItem
                        opacity: 1
                    }

                },
                State {
                    name: "focused"
                    when: loginButton.activeFocus

                    PropertyChanges {
                        target: buttonBackground
                        color: Qt.lighter(config.LoginButtonBackgroundColor, 1.2)
                        opacity: 1
                    }

                    PropertyChanges {
                        target: loginButton.contentItem
                        opacity: 1
                    }

                },
                State {
                    name: "enabled"
                    when: loginButton.enabled

                    PropertyChanges {
                        target: buttonBackground
                        color: config.LoginButtonBackgroundColor
                        opacity: 1
                    }

                    PropertyChanges {
                        target: loginButton.contentItem
                        opacity: 1
                    }

                }
            ]
            transitions: [
                Transition {
                    PropertyAnimation {
                        properties: "opacity, color"
                        duration: 300
                    }

                }
            ]

            contentItem: Text {
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.pointSize: root.font.pointSize
                font.family: root.font.family
                color: config.LoginButtonTextColor
                text: parent.text
                opacity: 0.5
            }

            background: Rectangle {
                id: buttonBackground

                color: config.LoginButtonBackgroundColor
                opacity: 0.2
                radius: config.RoundCorners || 0
            }

        }

    }

    // select session
    SessionButton {
        id: sessionSelect

        anchors.horizontalCenter: parent.horizontalCenter
    }

    // empty space
    Item {
        height: 30
        width: parent.width
    }

    SystemButtons {
        id: systemButtons

        visible: true
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Connections {
        function onLoginSucceeded() {
        }

        function onLoginFailed() {
            failed = true;
            resetError.running ? resetError.stop() && resetError.start() : resetError.start();
        }

        target: sddm
    }

    Timer {
        id: resetError

        interval: 2000
        onTriggered: failed = false
        running: false
    }

}
