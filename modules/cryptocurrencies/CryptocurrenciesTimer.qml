import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Frame {
    id: root
    signal triggered()

    Timer {
        id: timer
        repeat: true
        triggeredOnStart: true
        interval: comboBox.currentValue
        onTriggered: () => root.triggered()
        Component.onCompleted: () => timer.start()
    }

    ColumnLayout {
        Text { text: "Refresh rate" }
        ComboBox {
            id: comboBox
            model: ListModel {
                ListElement { text: "1s"; value: 1000 }
                ListElement { text: "3s"; value : 3000 }
                ListElement { text: "10s"; value : 10000 }
                ListElement { text: "30s"; value: 30000 }
            }
            textRole: "text"
            valueRole: "value"
            currentIndex: 2
            onCurrentValueChanged: () => {
                timer.interval = comboBox.currentValue
                timer.restart()
            }
        }
    }
}
