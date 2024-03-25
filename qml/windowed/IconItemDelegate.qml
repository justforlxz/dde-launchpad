// SPDX-FileCopyrightText: 2024 UnionTech Software Technology Co., Ltd.
//
// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick 2.15
import QtQml.Models 2.15
import QtQuick.Controls 2.15
import org.deepin.dtk 1.0
import org.deepin.dtk.private 1.0

import org.deepin.launchpad 1.0

Control {
    id: root

    property string text: display.startsWith("internal/category/") ? getCategoryName(display.substring(18)) : display

    property string iconSource
    property bool dndEnabled: false

    Accessible.name: iconItemLabel.text

    signal itemClicked()
    signal menuTriggered()

    contentItem: ToolButton {
        focusPolicy: Qt.NoFocus
        contentItem: Column {
            anchors.fill: parent

            Item {
                // actually just a top padding
                width: 1
                height: 3
            }

            DciIcon {
                objectName: "appIcon"
                anchors.horizontalCenter: parent.horizontalCenter
                name: iconSource
                sourceSize: Qt.size(36, 36)
            }

            // as topMargin
            Item {
                width: 1
                height: 8
            }

            Label {
                id: iconItemLabel
                text: root.text
                textFormat: Text.PlainText
                width: parent.width
                leftPadding: 2
                rightPadding: 2
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                maximumLineCount: 2
                font: DTK.fontManager.t9
            }    
        }
        background: ButtonPanel {
            button: parent
            outsideBorderColor: null
            radius: 8
        }

        onClicked: {
            root.itemClicked()
        }
    }
    background: DebugBounding { }

    TapHandler {
        acceptedButtons: Qt.RightButton
        onTapped: {
            root.menuTriggered()
        }
    }

    Keys.onSpacePressed: {
        root.itemClicked()
    }

    Keys.onReturnPressed: {
        root.itemClicked()
    }
}