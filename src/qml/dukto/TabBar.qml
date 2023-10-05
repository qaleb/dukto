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

Item {
    id: tabBar
    height: 65
    state: "buddies"

    signal clicked(string tab)

    Item {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        SmoothText {
            id: buddyText
            // anchors.left: parent.left
            // anchors.fill: contentWidth
            x: 10
            font.pixelSize: 84
            text: qsTr("buddies")
            width: buddyText.text.width
            transformOrigin: Item.TopLeft
            color: buddyTextMouseArea.containsMouse ? theme.color3 : theme.color7
            scale: 0.5

            MouseArea {
                id: buddyTextMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    tabBar.state = "buddies";
                    tabBar.clicked("buddies");
                }
            }
        }

        SmoothText {
            id: recentText
            // anchors.left: buddyText.right
            // anchors.fill: contentWidth
            x: 180
            font.pixelSize: 84
            text: qsTr("recent")
            width: recentText.text.width
            transformOrigin: Item.TopLeft
            color: recentTextMouseArea.containsMouse ? theme.color3 : theme.color7
            scale: 0.5

            MouseArea {
                id: recentTextMouseArea
                anchors.fill: parent;
                hoverEnabled: true;
                onClicked: {
                    tabBar.state = "recent";
                    tabBar.clicked("recent");
                }
            }
        }

        SmoothText {
            id: aboutText
            // anchors.left: recentText.right
            // anchors.fill: contentWidth
            x: 310
            font.pixelSize: 84
            color: aboutTextMouseArea.containsMouse ? theme.color3 : theme.color7
            text: qsTr("about")
            width: aboutText.text.width
            MouseArea {
                id: aboutTextMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    tabBar.state = "about";
                    tabBar.clicked("about");
                }
            }
        }
    }
    states: [
        State {
            name: "buddies"

            PropertyChanges {
                target: buddyText
                color: theme.color2 // "#000000"
            }
        },
        State {
            name: "recent"

            PropertyChanges {
                target: buddyText
                x: -55
            }

            PropertyChanges {
                target: recentText
                x: 100
                color: theme.color2 // "#000000"
            }

            PropertyChanges {
                target: aboutText
                x: 235
            }
        },
        State {
            name: "about"

            PropertyChanges {
                target: buddyText
                x: -120
            }

            PropertyChanges {
                target: recentText
                x: 52
            }

            PropertyChanges {
                target: aboutText
                x: 190
                color: theme.color2 // "#000000"
            }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuart; duration: 1000 }
            ColorAnimation  { duration: 300 }
        }
    ]
}
