//
//  LingoLockWidgetLiveActivity.swift
//  LingoLockWidget
//
//  Created by Max Fuligni on 9/5/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LingoLockWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct LingoLockWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LingoLockWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension LingoLockWidgetAttributes {
    fileprivate static var preview: LingoLockWidgetAttributes {
        LingoLockWidgetAttributes(name: "World")
    }
}

extension LingoLockWidgetAttributes.ContentState {
    fileprivate static var smiley: LingoLockWidgetAttributes.ContentState {
        LingoLockWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: LingoLockWidgetAttributes.ContentState {
         LingoLockWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: LingoLockWidgetAttributes.preview) {
   LingoLockWidgetLiveActivity()
} contentStates: {
    LingoLockWidgetAttributes.ContentState.smiley
    LingoLockWidgetAttributes.ContentState.starEyes
}
