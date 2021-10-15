//
//  DailyWeatherCard.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 11/10/2021.
//

import SwiftUI

struct DailyWeatherCard: View {
    
    @ObservedObject var settings = Settings()
    let weather: Daily
    
    var body: some View {
        VStack (spacing: 25) {
            HStack {
                if let image = weather.weather.first?.icon {
                    Image(systemName: settings.getImage(icon: image))
                        .font(.system(size: 60, weight: .semibold, design: .rounded))
                        .frame(maxWidth: .infinity)
                }
                
                VStack (alignment: .leading, spacing: 3) {
                    Text(settings.getDayFromInt(weather.dt))
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Text(settings.getTemp(weather.temp.day))
                            .bold()
                        Spacer()
                        
                        Text(settings.getTemp(weather.temp.night))
                            .bold()
                            .opacity(0.8)
                        Spacer()
                        Spacer()
                    }
                    .font(.largeTitle)
                    
                    if let description = weather.weather.first?.description {
                        Text(description.capitalizedFirstLetter())
                            .italic()
                        Text("Throught The Day")
                            .italic()
                    }
                }
                .font(.callout)
                .frame(maxWidth: .infinity)
            }
            
            getWeatherInfo(weather)
        }
        .foregroundColor(Color.theme.font)
        .frame(width: 360, height: 180)
        .background(Color.theme.background)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

struct DailyWeatherCard_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherCard(weather: Daily(dt: 1, sunrise: 1, sunset: 1, temp: Temp(day: 10, night: 8), humidity: 80, wind_speed: 70, weather: [Weather(icon: "", description: "")], clouds: 70, rain: 0.5))
            .padding()
    }
}

extension DailyWeatherCard {
    
    private func weatherLabel(icon: String, text: String) -> some View {
        HStack (spacing: 3) {
            Image(systemName: icon)
            Text(text)
        }
    }
    
    private func getWeatherInfo(_ weather:  Daily) -> some View {
        HStack {
            Spacer()
            weatherLabel(icon: "cloud.drizzle.fill", text: "\(weather.rain ?? 0)" + " mm")
            Spacer()
            weatherLabel(icon: "humidity", text: "\(weather.humidity)" + "%")
            Spacer()
            weatherLabel(icon: "wind", text: settings.getSpeed(weather.wind_speed))
            Spacer()
            weatherLabel(icon: "smoke.fill", text: "\(weather.clouds)" + "%")
            Spacer()
        }
    }
}
