//
//  LockScreenMetroWidgetView.swift
//  MetroWidgetExtension
//
//  Created by Alberto Finardi on 16/12/22.
//

import SwiftUI
import WidgetKit

struct LockScreenMetroWidgetView: View {
    let context : ActivityViewContext<MetroWidgetAttributes>
    var body: some View {
        VStack {
            HStack {
                Text(context.attributes.cityName)
                    .font(.subheadline)
                Spacer()
                //RoundedRectangle(cornerRadius: 12).opacity(0.1)
                Text(context.attributes.lineName)
                    .font(.subheadline)
            }
            Group {
                switch context.state.state {
                    case .initialized:
                        Text("Start moving")
                            .font(.title)
                    case .ended:
                        Text("Ended")
                            .font(.title)
                    case .using:
                        VStack {
                            Text("Closest stop:")
                                .font(.title3)
                            Text("\(context.state.stop?.name ?? "IDK")")
                                .font(.title)
                        }
                        
                    case .successful:
                        VStack {
                            Text("You arrived at:")
                                .font(.title3)
                            Text("\(context.state.stop?.name ?? "Unknow")")
                                .font(.title)
                        }
                }
            }
        }
        .bold()
        .padding()
        .activityBackgroundTint(Color(uiColor: hexStringToUIColor(hex: context.attributes.lineColor)))
        .foregroundColor(.white)
    }
}

struct LockScreenMetroWidgetView_Previews: PreviewProvider {
    static let attributes = MetroWidgetAttributes(cityName: "Milano", lineName: "M2", lineColor: "Verde")
    static let contentState = MetroWidgetAttributes.ContentState(state: .using)
    
    static var previews: some View {
        attributes
            .previewContext(contentState, viewKind: .content)
            .previewDisplayName("Notification")
    }
}
