import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Frame {
    id: root

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            CryptocurrenciesBaseCurrency {
                id: cryptocurrenciesBaseCurrency
                onErrorOccured: (headerText, bodyText) => cryptocurrenciesPopup.show(headerText, bodyText)
                onCurrencyChanged: (currency) => {
                    cryptocurrenciesList.currency = currency
                    cryptocurrenciesList.requestData()
                }
            }

            CryptocurrenciesTimer {
                id: cryptocurrenciesTimer
                onTriggered: () => {
                    if(cryptocurrenciesList.currency === "") cryptocurrenciesBaseCurrency.requestData()
                    else cryptocurrenciesList.requestData()
                }
            }

            CryptocurrenciesFetchIndicator {
                id: cryptocurrenciesFetchIndicator
                fetching: cryptocurrenciesBaseCurrency.fetching || cryptocurrenciesList.fetching
                error: cryptocurrenciesBaseCurrency.error || cryptocurrenciesList.error
            }
        }

        CryptocurrenciesList {
            id: cryptocurrenciesList
            Layout.fillWidth: true
            Layout.fillHeight: true
            onErrorOccured: (headerText, bodyText) => cryptocurrenciesPopup.show(headerText, bodyText)
        }
    }

    CryptocurrenciesPopup {
        id: cryptocurrenciesPopup
        anchors.centerIn: parent
    }
}
