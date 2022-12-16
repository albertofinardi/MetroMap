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
    @ObservedObject var vm = MainViewModel()
    var body: some View {
        NavigationView {
            Form {
                Section("Setup") {
                    Picker("Select city", selection: $vm.city) {
                        ForEach(vm.db, id: \.self) { city in
                            Text(city.name)
                        }
                    }
                    
                    Picker("Select line", selection: $vm.line) {
                        ForEach(vm.city.lines, id: \.self) { line in
                            Text(line.name)
                        }
                    }
                    
                    Picker("Select stop", selection: $vm.stop) {
                        ForEach(vm.line.stops, id: \.self) { line in
                            Text(line.name)
                        }
                    }
                }
                
                
                Section {
                    Button("Start") {
                        vm.startLiveActivity()
                    }
                    Button("Stop") {
                        vm.stopLiveActivity()
                    }

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
