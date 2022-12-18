//
//  MainPage.swift
//  MetroMap
//
//  Created by Alberto Finardi on 18/12/22.
//

import SwiftUI

struct MainPage: View {
    @ObservedObject var vm = MainViewModel()
    var body: some View {
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
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
