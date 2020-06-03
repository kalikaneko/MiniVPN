import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Extras 1.2
import Qt.labs.platform 1.1

ApplicationWindow {

    id: app
    visible: false

    property var     ctx
    property string  appName

    Connections {
        target: jsonModel
        onDataChanged: {
            ctx = JSON.parse(jsonModel.getJson());
        }
    }

    Component.onCompleted: {
        /* stupid as it sounds, windows doesn't like to have the systray icon
         not being attached to an actual application window.
         We can still use this quirk, and can use the AppWindow with deferred
         Loaders as a placeholder for all the many dialogs, or to load
         a nice splash screen etc...  */
        app.visible = true;
        hide();
    }

    SystemTrayIcon {

        id: systray
        visible: true
        onActivated: menu.open()

        Component.onCompleted: {
            icon.source = "qrc:/assets/vpn-off.png"
            tooltip = qsTr("Checking status...")
            console.debug("systray init completed")
            appName = "RiseupVPN"; // TODO get it from ctx
            show();
        }


        menu: Menu {
            StateGroup {
                id: vpn
                state: ctx ? ctx.status : ""
                states: [
                    State { name: "initializing" },
                    State {
                        name: "off"
                        PropertyChanges { target: systray; tooltip: qsTr(appName + " off"); icon.source: "qrc:/assets/vpn-off.png" }
                        PropertyChanges { target: statusItem; text: qsTr(appName + " off") }
                    },
                    State {
                        name: "on"
                        PropertyChanges { target: systray; tooltip: qsTr("RiseupVPN on"); icon.source: "qrc:/assets/vpn-on.svg" }
                        PropertyChanges { target: statusItem; text: qsTr("RiseupVPN on") }
                    },
                    State {
                        name: "starting"
                       PropertyChanges { target: systray; tooltip: qsTr("Connecting to RiseupVPN"); icon.source: "qrc:/assets/vpn-wait.svg" }
                        PropertyChanges { target: statusItem; text: qsTr("Connecting to RiseupVPN") }
                    },
                    State {
                        name: "stopping"
                        PropertyChanges { target: systray; tooltip: qsTr("Stopping RiseupVPN"); icon.source: "qrc:/assets/vpn-wait.svg" }
                        PropertyChanges { target: statusItem; text: qsTr("Stopping RiseupVPN") }
                    },
                    State {
                        name: "failed"
                        PropertyChanges { target: systray; tooltip: qsTr("RiseupVPN blocking internet"); icon.source: "qrc:/assets/vpn-blocked.svg" }
                        PropertyChanges { target: statusItem; text: qsTr("RiseupVPN blocking internet") }
                    }
                ]
            }

            /*
            LoginDialog {
                id: login
            }
            DonateDialog {
                id: donate
            }
            MessageDialog {
                id: about
                buttons: MessageDialog.Ok
                title: "About"
                text: "<p>%1 is an easy, fast, and secure VPN service from %2. %1 does not require a user account, keep logs, or track you in any way.</p>
    <p>This service is paid for entirely by donations from users like you. <a href=\"%3\">Please donate</a>.</p>
    <p>By using this application, you agree to the <a href=\"%4\">Terms of Service</a>. This service is provided as-is, without any warranty, and is intended for people who work to make the world a better place.</p>".arg(ctxSystray.applicationName).arg(ctxSystray.provider).arg(ctxSystray.donateURL).arg(ctxSystray.tosURL)
                informativeText: "%1 version: %2".arg(ctxSystray.applicationName).arg(ctxSystray.version)
            }
            MessageDialog {
                id: errorStartingVPN
                buttons: MessageDialog.Ok
                modality: Qt.NonModal
                title: "Error starting VPN"
                text: "Can't connect to %1".arg(ctxSystray.applicationName)
                detailedText: ctxSystray.errorStartingMsg
                visible: ctxSystray.errorStartingMsg != ""
            }
            MessageDialog {
                id: authAgent
                buttons: MessageDialog.Ok
                modality: Qt.NonModal
                title: "Missing authentication agent"
                text: "Could not find a polkit authentication agent. Please run one and try again."
                visible: ctxSystray.authAgent == true
            }
            MessageDialog {
                id: initFailure
                buttons: MessageDialog.Ok
                modality: Qt.NonModal
                title: "Initialization Error"
                text: ctxSystray.errorInitMsg
                visible: ctxSystray.errorInitMsg != ""
            }
            */

            MenuItem {
                id: statusItem
                text: qsTr("Checking status...")
                enabled: false
            }

            MenuItem {
                text: {
                    if (vpn.state == "failed")
                        qsTr("Reconnect")
                    else
                        qsTr("Turn on")
                }
                onTriggered: {
                    backend.switchOn()
                }
                visible: ctx ? (ctx.status == "off" || ctx.status == "failed") : false
            }

            MenuItem {
                text: {
                    if (ctx && ctx.status == "starting")
                        qsTr("Cancel")
                    else
                        qsTr("Turn off")
                }
                onTriggered: {
                    backend.switchOff()
                }
                visible: ctx ? (ctx.status == "on" || ctx.status == "starting" || ctx.status == "failed") : false
            }

            MenuSeparator {}

            MenuItem {
                text: qsTr("Help...")
                //onTriggered: ctxSystray.help()
            }

            MenuItem {
                text: qsTr("Donate...")
                //onTriggered: ctxSystray.donate()
                visible: true
                //visible: ctx.showDonate
            }

            MenuItem {
                text: qsTr("About...")
                //onTriggered: about.open()
            }

            MenuSeparator {}

            MenuItem {
                text: qsTr("Quit")
                onTriggered: backend.quit()
            }
        }
    }
}
