//
//  HabitWidgetExtensionLiveActivity.swift
//  HabitWidgetExtension
//
//  Created by mustafaolmezses on 24.01.2026.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct HabitWidgetExtensionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct HabitWidgetExtensionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: HabitWidgetExtensionAttributes.self) { context in
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

extension HabitWidgetExtensionAttributes {
    fileprivate static var preview: HabitWidgetExtensionAttributes {
        HabitWidgetExtensionAttributes(name: "World")
    }
}

extension HabitWidgetExtensionAttributes.ContentState {
    fileprivate static var smiley: HabitWidgetExtensionAttributes.ContentState {
        HabitWidgetExtensionAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: HabitWidgetExtensionAttributes.ContentState {
         HabitWidgetExtensionAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: HabitWidgetExtensionAttributes.preview) {
   HabitWidgetExtensionLiveActivity()
} contentStates: {
    HabitWidgetExtensionAttributes.ContentState.smiley
    HabitWidgetExtensionAttributes.ContentState.starEyes
}
