cmake_minimum_required(VERSION 3.25)
project(cryptotracker)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()
qt_add_executable(cryptotracker)

set_target_properties(cryptotracker PROPERTIES
  CXX_STANDARD 23
  CXX_EXTENSIONS TRUE
  CXX_STANDARD_REQUIRED TRUE
)

target_link_libraries(cryptotracker PRIVATE
  Qt6::Quick
)

target_sources(cryptotracker PRIVATE
  main.cpp
)

qt_add_qml_module(cryptotracker
  URI CryptoTracker
  VERSION 1.0
  QML_FILES
    Main.qml

    modules/cryptocurrencies/Cryptocurrencies.qml
    modules/cryptocurrencies/CryptocurrenciesBaseCurrency.qml
    modules/cryptocurrencies/cryptocurrenciesBaseCurrency.mjs
    modules/cryptocurrencies/CryptocurrenciesTimer.qml
    modules/cryptocurrencies/CryptocurrenciesFetchIndicator.qml
    modules/cryptocurrencies/CryptocurrenciesList.qml
    modules/cryptocurrencies/cryptocurrenciesList.mjs
    modules/cryptocurrencies/CryptocurrenciesPopup.qml
)

include(GNUInstallDirs)
install(TARGETS cryptotracker
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

qt_generate_deploy_qml_app_script(TARGET cryptotracker
        FILENAME_VARIABLE deploy_script
        NO_UNSUPPORTED_PLATFORM_ERROR
        DEPLOY_USER_QML_MODULES_ON_UNSUPPORTED_PLATFORM
)
install(SCRIPT ${deploy_script})
