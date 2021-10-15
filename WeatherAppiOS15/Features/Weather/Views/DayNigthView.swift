//
//  DayNigthView.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 12/10/2021.
//

import SwiftUI

struct DayNigthView: View {
    
    @ObservedObject var settings = Settings()
    let weather: Daily
    
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "sunrise")
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color.theme.font, Color.theme.font.opacity(0.4))
                .font(.title)
            Text(settings.getDateFromInt(weather.sunrise))
            
            Spacer()
            
            Text(settings.getDateFromInt(weather.sunset))
            Image(systemName: "sunset")
                .foregroundStyle(Color.theme.font, Color.theme.font.opacity(0.4))
                .font(.title)
            
            Spacer()
        }
        .padding(.top, 10)
        .foregroundColor(Color.theme.font)
    }
}

struct DayNigthView_Previews: PreviewProvider {
    static var previews: some View {
        DayNigthView(weather: Daily(dt: 1, sunrise: 10, sunset: 10, temp: Temp(day: 10, night: 10), humidity: 10, wind_speed: 10, weather: [Weather(icon: "", description: "")], clouds: 10, rain: 10))
    }
}
