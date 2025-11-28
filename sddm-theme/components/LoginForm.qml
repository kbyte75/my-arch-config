import QtQuick 2.15
import QtQuick.Layouts 1.15
import SddmComponents 2.0 as SDDM

ColumnLayout {
    id: formContainer

    property int p: config.ScreenPadding == "" ? 0 : config.ScreenPadding
    property string a: config.FormPosition

    SDDM.TextConstants {
        id: textConstants
    }

    Clock {
        id: clock

        Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
    }

    Input {
        id: input

        Layout.alignment: Qt.AlignVCenter | Qt.AlignCenter
    }

}
