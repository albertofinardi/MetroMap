//
//  MetroWidgetLiveActivity.swift
//  MetroWidget
//
//  Created by Alberto Finardi on 16/12/22.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct MetroWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MetroWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            LockScreenMetroWidgetView(context: context)
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
                    Text("Bottom")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T")
            } minimal: {
                Text("Min")
            }
            //.widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

struct MetroWidgetLiveActivity_Previews: PreviewProvider {
    static let attributes = MetroWidgetAttributes(cityName: "Milano", lineName: "M2", lineColor: "Verde")
    static let contentState = MetroWidgetAttributes.ContentState(state: .initialized)

    static var previews: some View {
        /*attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.compact))
            .previewDisplayName("Island Compact")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Island Expanded")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.minimal))
            .previewDisplayName("Minimal")*/
        attributes
            .previewContext(contentState, viewKind: .content)
            .previewDisplayName("Notification")
    }
}
