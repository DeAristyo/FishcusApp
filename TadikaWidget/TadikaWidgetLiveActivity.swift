//
//  TadikaWidgetLiveActivity.swift
//  TadikaWidget
//
//  Created by Dimas Aristyo Rahadian on 13/10/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TadikaWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct TadikaWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TadikaWidgetAttributes.self) { context in
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

extension TadikaWidgetAttributes {
    fileprivate static var preview: TadikaWidgetAttributes {
        TadikaWidgetAttributes(name: "World")
    }
}

extension TadikaWidgetAttributes.ContentState {
    fileprivate static var smiley: TadikaWidgetAttributes.ContentState {
        TadikaWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: TadikaWidgetAttributes.ContentState {
         TadikaWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: TadikaWidgetAttributes.preview) {
   TadikaWidgetLiveActivity()
} contentStates: {
    TadikaWidgetAttributes.ContentState.smiley
    TadikaWidgetAttributes.ContentState.starEyes
}
