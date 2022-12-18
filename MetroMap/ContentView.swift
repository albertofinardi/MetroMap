//
//  ContentView.swift
//  MetroMap
//
//  Created by Alberto Finardi on 16/12/22.
//

import SwiftUI
import ActivityKit
import CoreLocation

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                MainPage()
                    .tabItem {
                        Label("Notify", systemImage: "bell.and.waveform")
                    }
                MapPage()
                    .tabItem {
                        Label("Map", systemImage: "map")
                    }
            }
            .navigationTitle("MetroMap")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
