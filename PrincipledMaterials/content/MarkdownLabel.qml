import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Item {
    // This is to hide the Label's implicitWidth from any layout
    // since the label reports the unwrapped width instead of
    // the wrapped width
    property alias text: label.text
    Layout.fillWidth: true
    height: label.implicitHeight
    implicitWidth: width
    implicitHeight: label.implicitHeight
    Label {
        id: label
        width: parent.width
        textFormat: Text.MarkdownText
        wrapMode: Text.WordWrap
    }
}
