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

import QtQuick 2.15

Rectangle {
    id: sendPage
    color: theme.color6

    signal back()
    signal showTextPage()

    function setDestinationFocus() {
        destinationText.focus = true;
    }

    MouseArea {
        anchors.fill: parent
    }

    Image {
        id: backIcon
        source: "BackIconDark.png"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.leftMargin: 5

        MouseArea {
            anchors.fill: parent
            onClicked: sendPage.back();
        }
    }

    DropArea {
       id: dropTarget
       anchors.fill: parent

       /*onEntered: {
           // Handle when an item is dragged over this area
           console.log("A file is on top of me.");
       }*/

       onDropped: {
           if (drop.hasUrls) {
               var filesList = drop.urls.map(function(url) { return url.toString(); });
               console.log(filesList);
               // Pass the list of file URLs to the sendDroppedFiles function
               guiBehind.sendBuddyDroppedFiles(filesList);
           }
       }

       Rectangle {
           anchors.fill: parent
           color: "#00000000"
//           visible: buddyMouseArea.containsMouse

           Rectangle {
               anchors.right: parent.right
               anchors.top: parent.top
               height: 64
               width: 5
               color: theme.color3
           }
       }
   }

    SmoothText {
        id: boxTitle
        anchors.left: backIcon.right
        anchors.top: parent.top
        anchors.leftMargin: 15
        anchors.topMargin: 5
        font.pixelSize: 64
        text: qsTr("Send data to")
        color: theme.color3
    }

    BuddyListElement {
        id: localBuddy
        visible: destinationBuddy.ip !== "IP"
        anchors.top: backIcon.bottom
        anchors.topMargin: 25
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.right: parent.right
        buddyGeneric: destinationBuddy.genericAvatar
        buddyAvatar: destinationBuddy.avatar
        buddyOsLogo:destinationBuddy.osLogo
        buddyUsername: destinationBuddy.username
        buddySystem: destinationBuddy.system
        buddyIpAddress: destinationBuddy.ip.substring(7)
        buddyIp: "-"
    }

    BuddyListElement {
        id: remoteBuddy
        visible: destinationBuddy.ip === "IP"
        anchors.top: backIcon.bottom
        anchors.topMargin: 25
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.right: parent.right
        buddyGeneric: "UnknownLogo.png"
        buddyAvatar: ""
        buddyOsLogo: ""
        buddyUsername: qsTr("Destination:")
        buddySystem: ""
        buddyIp: "-"
    }

    Rectangle {
        id: destRect
        visible: destinationBuddy.ip === "IP"
        anchors.right: localBuddy.right
        anchors.bottom: localBuddy.bottom
        anchors.bottomMargin: 5
        anchors.rightMargin: 20
        border.color: theme.color5
        border.width: 2
        width: 225
        height: 25

        TextInput {
            id: destinationText
            anchors.fill: parent
            anchors.margins: 4
            readOnly: false
            smooth: true
            font.pixelSize: 14
            color: theme.color5
            selectByMouse: true
            focus: true
        }

        Binding {
            target: guiBehind
            property: "remoteDestinationAddress"
            value: destinationText.text
        }
    }

    SText {
        id: labelAction
        anchors.left: localBuddy.left
        anchors.top: localBuddy.bottom
        anchors.topMargin: 35
        font.pixelSize: 17
        color: theme.color4
        text: qsTr("What do you want to do?")
    }

    ButtonDark {
        id: buttonSendText
        anchors.top: labelAction.bottom
        anchors.topMargin: 15
        anchors.left: localBuddy.left
        width: 300
        buttonEnabled: guiBehind.currentTransferBuddy !== ""
        label: qsTr("Send some text")
        onClicked: sendPage.showTextPage();
    }

    ButtonDark {
        id: buttonSendClipboardText
        anchors.top: buttonSendText.bottom
        anchors.topMargin: 15
        anchors.left: localBuddy.left
        width: 300
        label: qsTr("Send text from clipboard")
        buttonEnabled: guiBehind.clipboardTextAvailable && (guiBehind.currentTransferBuddy !== "")
        onClicked: guiBehind.sendClipboardText()
    }

    ButtonDark {
        id: buttonSendFiles
        anchors.top: buttonSendClipboardText.bottom
        anchors.topMargin: 15
        anchors.left: localBuddy.left
        width: 300
        buttonEnabled: guiBehind.currentTransferBuddy !== ""
        label: qsTr("Send some files")
        onClicked: guiBehind.sendSomeFiles()
    }

    ButtonDark {
        id: buttonSendFolder
        anchors.top: buttonSendFiles.bottom
        anchors.topMargin: 15
        anchors.left: localBuddy.left
        width: 300
        buttonEnabled: guiBehind.currentTransferBuddy !== ""
        label: qsTr("Send a folder")
        onClicked: guiBehind.sendFolder()
    }

    ButtonDark {
        id: buttonSendScreen
        anchors.top: buttonSendFolder.bottom
        anchors.topMargin: 15
        anchors.left: localBuddy.left
        width: 300
        buttonEnabled: guiBehind.currentTransferBuddy !== ""
        label: "Send a screenshot"
        onClicked: guiBehind.sendScreen()
    }

    SText {
        id: labelDrop
        anchors.left: localBuddy.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        font.pixelSize: 14
        color: theme.color5
        text: qsTr("Or simply drag & drop some files and folders\nover this window to send them to your buddy.")
    }
}
