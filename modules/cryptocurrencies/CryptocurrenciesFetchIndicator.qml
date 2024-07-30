import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    id: root
    property bool fetching: false
    property bool error: false

    BusyIndicator {
        visible: root.fetching
        running: root.fetching
    }

    Text {
        visible: root.fetching
        text: "Fetching data..."
    }

    Image {
        visible: root.error
        source: "/icons/exclamation-circle.svg"
        sourceSize.height: 30
    }

    Text {
        visible: root.error
        text: "An error occurred during fetching."
    }
}
