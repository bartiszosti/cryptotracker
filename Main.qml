import QtQuick
import Cryptocurrencies

Window {
    width: 1366
    height: 768
    visible: true
    title: "cryptotracker"

    Cryptocurrencies { anchors.fill: parent }
}
