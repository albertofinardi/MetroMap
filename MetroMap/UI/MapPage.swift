//
//  MapPage.swift
//  MetroMap
//
//  Created by Alberto Finardi on 18/12/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MapPage: View {
    var body: some View {
        ZoomableScrollView {
            WebImage(url: URL(string: "https://www.atm.it/en/ViaggiaConNoi/PublishingImages/schema%20rete%20metro.jpg"))
                .resizable()
                .indicator(.activity)
                .scaledToFit()
                .padding()
                .clipped()
        }
    }
}

struct MapPage_Previews: PreviewProvider {
    static var previews: some View {
        MapPage()
    }
}
