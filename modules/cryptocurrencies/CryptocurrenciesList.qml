import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.qmlmodels

Frame {
    id: root
    property bool fetching: false
    property bool error: false
    property string currency: ""
    property var sortBy: -1
    function requestData() {
        root.fetching = true
        root.error = false
        workerScript.sendMessage({ "currency": root.currency, "sortBy": root.sortBy })
    }
    signal errorOccured(string headerText, string bodyText)

    WorkerScript {
        id: workerScript
        source: "cryptocurrenciesList.mjs"
        onMessage: (message) => {
            if(message.status === 200) {
                tableView.model.clear()
                for(let row in message.data)
                    tableView.model.appendRow(message.data[row])
            }
            else {
                root.error = true
                root.errorOccured(message.status, message.data)
            }
            root.fetching = false
        }
    }

    HorizontalHeaderView {
        id: horizontalHeaderView
        clip: true
        syncView: tableView
        model: [ "Coin", "Price", "24h", "24h Volume", "Market Cap", "Last updated" ]
        delegate: Rectangle {
            implicitWidth: 1
            implicitHeight: 50

            RowLayout {
                anchors.centerIn: parent

                Text { text: modelData }

                RoundButton {
                    readonly property var sortBy: model.index * 2
                    text: {
                        if(root.sortBy === sortBy) return "x"
                        else return "-"
                    }
                    onClicked: () => {
                        if(root.sortBy === sortBy) root.sortBy = -1
                        else root.sortBy = sortBy
                        root.requestData()
                    }
                }

                RoundButton {
                    readonly property var sortBy: (model.index * 2) + 1
                    text: {
                        if(root.sortBy === sortBy) return "x"
                        else return "+"
                    }
                    onClicked: () => {
                        if(root.sortBy === sortBy) root.sortBy = -1
                        else root.sortBy = sortBy
                        root.requestData()
                    }
                }
            }
        }
        anchors.left: tableView.left
        anchors.top: parent.top
    }

    TableView {
        id: tableView
        clip: true
        columnSpacing: 1
        rowSpacing: 1
        model: TableModel {
            TableModelColumn { display: "name" }
            TableModelColumn { display: "current_price" }
            TableModelColumn { display: "price_change_percentage_24h" }
            TableModelColumn { display: "total_volume" }
            TableModelColumn { display: "market_cap" }
            TableModelColumn { display: "last_updated" }
        }
        delegate: DelegateChooser {
            DelegateChoice {
                column: 0
                delegate: Rectangle {
                    implicitWidth: 300
                    implicitHeight: 50

                    RowLayout {
                        anchors.fill: parent

                        Image {
                            asynchronous: true
                            source: tableView.model.getRow(model.row).image
                            sourceSize.height: 30
                        }
                        Text { text: display; Layout.fillWidth: true }
                    }
                }
            }
            DelegateChoice {
                delegate: Rectangle {
                    implicitWidth: 200
                    implicitHeight: 50

                    Text {
                        text: {
                            if(model.column === 2)
                                return Number(display).toFixed(2)
                            else if(model.column === 5)
                                return new Date(display).toLocaleString(Qt.locale("en_US"), Locale.ShortFormat)
                            else
                                return display
                        }
                        anchors.centerIn: parent
                    }
                }
            }
        }
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: horizontalHeaderView.bottom
        anchors.bottom: parent.bottom
    }
}
