import QtQuick 2.15
import QtQuick.Controls 2.15

Column {
    id: clock

    width: parent.width / 2
    spacing: 0
    Component.onCompleted: {
        dateLabel.updateTime();
        timeLabel.updateTime();
    }

    Label {
        id: timeLabel

        function updateTime() {
            text = new Date().toLocaleTimeString(Qt.locale(config.Locale), config.HourFormat == "long" ? Locale.LongFormat : config.HourFormat !== "" ? config.HourFormat : Locale.ShortFormat);
        }

        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: root.font.pointSize * 9
        font.bold: true
        color: config.TimeTextColor || "#040404"
        renderType: Text.QtRendering
    }

    Label {
        id: dateLabel

        function updateTime() {
            text = new Date().toLocaleDateString(Qt.locale(config.Locale), config.DateFormat == "short" ? Locale.ShortFormat : config.DateFormat !== "" ? config.DateFormat : Locale.LongFormat);
        }

        anchors.horizontalCenter: parent.horizontalCenter
        color: config.DateTextColor
        font.pointSize: root.font.pointSize * 2
        font.bold: true
        renderType: Text.QtRendering
    }

    Label {
        id: headerTextLabel

        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: root.font.pointSize * 3
        color: config.HeaderTextColor
        renderType: Text.QtRendering
        text: config.HeaderText
    }

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            dateLabel.updateTime();
            timeLabel.updateTime();
        }
    }

}
