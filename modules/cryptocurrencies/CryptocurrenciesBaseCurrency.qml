import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Frame {
    id: root
    property bool fetching: false
    property bool error: false
    function requestData() {
        root.fetching = true
        root.error = false
        workerScript.sendMessage()
    }
    signal errorOccured(string headerText, string bodyText)
    signal currencyChanged(string currency)

    WorkerScript {
        id: workerScript
        source: "cryptocurrenciesBaseCurrency.mjs"
        onMessage: (message) => {
            if(message.status === 200) {
                comboBox.model.clear()
                comboBox.model.append(message.data)
                comboBox.currentIndex = 0
                comboBox.enabled = true
            }
            else {
                root.error = true
                root.errorOccured(message.status, message.data)
            }
            root.fetching = false
        }
    }

    ColumnLayout {
        Text { text: "Base currency" }
        ComboBox {
            id: comboBox
            enabled: false
            model: ListModel {}
            textRole: "text"
            valueRole: "value"
            onCurrentValueChanged: () => root.currencyChanged(comboBox.currentValue)
        }
    }
}
