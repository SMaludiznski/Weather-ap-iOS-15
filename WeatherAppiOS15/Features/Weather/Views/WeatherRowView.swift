//
//  WeatherView.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 12/10/2021.
//

import SwiftUI

struct WeatherRowView: View {
    
    @ObservedObject var settings = Settings()
    let weather: Hourly
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(settings.getDateFromInt(weather.dt))
                
                Spacer()
                Text(settings.getTemp(weather.temp))
                
                Spacer()
                if let image = weather.weather.first?.icon {
                    Image(systemName: settings.getImage(icon: image))
                        .font(.system(size: 25, weight: .semibold))
                }
                
                Spacer()
            }
            .font(.title2)
            .foregroundColor(Color.theme.font)
            .frame(maxWidth: .infinity)
            Divider()
        }
    }
}

struct WeatherRowView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRowView(weather: Hourly(dt: 1, temp: 12, weather: [Weather(icon: "", description: "")]))
    }
}
