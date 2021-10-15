//
//  SettingsView.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 11/10/2021.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var vm = Settings()
    
    var body: some View {
        VStack {
            header
            
            VStack (spacing: 15) {
                Toggle("Temperature - °" + (vm.temperatureInC ? "C" : "F"), isOn: $vm.temperatureInC)
                Toggle("Wind speed - " + (vm.windSpeedInKm ? "Km/h" : "Mph"), isOn: $vm.windSpeedInKm)
            }
            .padding(33)
            
            Divider()
            
            VStack (alignment: .leading, spacing: 10) {
                Text("ABOUT:")
                    .font(.system(size: 20, weight: .light, design: .rounded))
                
                Text("Version: \(vm.getVersion())")
                
                VStack (alignment: .leading) {
                    Text("Author:")
                    Text("Sebastian Maludziński")
                }

                Text("Weather info: Powered by Open Weather Map")
            }
            
            Spacer()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    private var header: some View {
        HStack {
            Image(systemName: "gearshape")
            Text("SETTINGS")
        }
        .padding(.top, 10)
        .font(.system(size: 27, weight: .light, design: .rounded))
    }
}
