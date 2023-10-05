/* DUKTO - A simple, fast and multi-platform file transfer tool for LAN users
 * Copyright (C) 2011 Emanuele Colombo
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

import QtQuick 2.3

Rectangle {
    color: "#00000000"
    state: guiBehind.showTermsOnStart ? "termspage" : ""

    function refreshSettingsColor() {
        settingsPage.refreshColor();
    }

    Rectangle {
        id: disabler
        anchors.fill: parent
        color: theme.color9
        opacity: 0
        visible: false

        MouseArea {
            anchors.fill: parent
        }
    }

    IpPage {
        id: ipPage
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        opacity: 0
        onBack: parent.state = ""
        visible: false
    }

    ProgressPage {
        id: progressPage
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        opacity: 0
        visible: false
    }

    ShowTextPage {
        id: showTextPage
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        opacity: 0
        onBack: parent.state = ""
        onBackOnSend: {
            sendPage.setDestinationFocus();
            parent.state = "send"
        }
        visible: false
    }

    SettingsPage {
        id: settingsPage
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        opacity: 0
        onBack: parent.state = ""
        visible: false
    }

    SendPage {
        id: sendPage
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        opacity: 0
        onBack: parent.state = ""
        onShowTextPage: {
            showTextPage.setTextEditFocus();
            parent.state = "showtext";
        }
        visible: false
    }

    MessagePage {
        id: messagePage
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        opacity: 0
        onBack: parent.state = backState
        visible: false
    }

    TermsPage {
        id: termsPage
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        opacity: 0
        onOk: {
            guiBehind.showTermsOnStart = false;
            parent.state = ""
        }
        visible: false
    }

    states: [
        State {
            name: "ip"
            PropertyChanges {
                target: ipPage
                opacity: 1
                visible: true
            }
            PropertyChanges {
                target: disabler
                opacity: 1
                visible: true
            }
        },
        State {
            name: "progress"
            PropertyChanges {
                target: progressPage
                opacity: 1
                visible: true
            }
            PropertyChanges {
                target: disabler
                opacity: 1
                visible: true
            }
        },
        State {
            name: "showtext"
            PropertyChanges {
                target: showTextPage
                opacity: 1
                visible: true
            }
        },
        State {
            name: "settings"
            PropertyChanges {
                target: settingsPage
                opacity: 1
                visible: true
            }
        },
        State {
            name: "send"
            PropertyChanges {
                target: sendPage
                opacity: 1
                visible: true
            }
        },
        State {
            name: "message"
            PropertyChanges {
                target: messagePage
                opacity: 1
                visible: true
            }
            PropertyChanges {
                target: disabler
                opacity: 1
                visible: true

            }
        },
        State {
            name: "termspage"
            PropertyChanges {
                target: termsPage
                opacity: 1
                visible: true
            }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutCubic; duration: 500 }
            NumberAnimation { properties: "opacity"; easing.type: Easing.OutCubic; duration: 500 }
        }
    ]
}

