cmake_minimum_required(VERSION 3.25)
project(cryptotracker)

set(QT_QML_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})

find_package(Qt6 REQUIRED COMPONENTS Concurrent Network Quick)

qt_standard_project_setup()
qt_add_executable(cryptotracker)

set_target_properties(cryptotracker PROPERTIES
  CXX_STANDARD 23
  CXX_EXTENSIONS TRUE
  CXX_STANDARD_REQUIRED TRUE
)

add_subdirectory(modules)

target_link_libraries(cryptotracker PRIVATE
  Qt6::Quick
  cryptocurrenciesplugin
)

target_sources(cryptotracker PRIVATE
  main.cpp
)

qt_add_qml_module(cryptotracker
  URI CryptoTracker
  VERSION 1.0
  QML_FILES
    Main.qml
)

include(GNUInstallDirs)
install(TARGETS cryptotracker
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
