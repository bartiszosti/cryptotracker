cmake_minimum_required(VERSION 3.25)
project(cryptocurrencies)

qt_standard_project_setup()
qt_add_library(cryptocurrencies STATIC)

qt_add_resources(cryptocurrencies images
  PREFIX /icons
  FILES
    exclamation-circle.svg
)

qt_add_qml_module(cryptocurrencies
  URI Cryptocurrencies
  VERSION 1.0
  QML_FILES
    Cryptocurrencies.qml
    CryptocurrenciesBaseCurrency.qml cryptocurrenciesBaseCurrency.mjs
    CryptocurrenciesTimer.qml
    CryptocurrenciesFetchIndicator.qml
    CryptocurrenciesList.qml cryptocurrenciesList.mjs
    CryptocurrenciesPopup.qml
)
