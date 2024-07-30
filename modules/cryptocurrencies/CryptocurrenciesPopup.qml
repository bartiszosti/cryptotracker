import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Popup {
    id: root
    modal: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnReleaseOutside
    contentItem: ColumnLayout {
        Text { id: header }
        Text { id: body }
    }
    function show(headerText, bodyText) {
        header.text = headerText
        body.text = bodyText
        root.open()
    }
}
