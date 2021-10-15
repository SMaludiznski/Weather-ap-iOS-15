//
//  WeatherView.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 11/10/2021.
//

import SwiftUI

struct WeatherView: View {
    
    @StateObject private var vm: WeatherViewModel = WeatherViewModel()
    
    var body: some View {
        VStack {
            //check if location service is on
            switch vm.locationState {
            case .failed(let error): FetchDataErrorView(errorText: error)
            //in default case location service is on
            default:
                //check for weather data download result
                switch vm.state {
                case .loading: FetchDataProgressView()
                case .failed(let error): FetchDataErrorView(errorText: error.localizedDescription)
                case .success(let data): getWeatherView(data: data)
                default: EmptyView()
                }
            }
        }
        .task {
            await vm.getWeather()
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
            WeatherView()
    }
}

extension WeatherView {
    
    private var header: some View {
        HStack {
            Image(systemName: "calendar")
            Text("DAILY SUMMARY")
        }
        .padding(.top, 10)
        .font(.system(size: 27, weight: .light, design: .rounded))
    }
    
    private var rainProbability: some View {
        HStack (spacing: 30) {
            Text("Possible drizzle today.")
            Image(systemName: "cloud.drizzle")
                .font(.system(size: 40, weight: .semibold))

        }
        .padding()
    }
    
    private func getWeatherView(data: MainWeatherModel) -> some View {
        VStack {
            header
            
            if data.daily.first?.rain != nil {
                rainProbability
            }
            
            //Daily weather section
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 40) {
                    ForEach(0 ..< 4) { index in
                        DailyWeatherCard(weather: data.daily[index])
                    }
                }
                .padding(15)
                .padding(.vertical, 10)
            }
            
            //Sunrise and sunset section
            if let date = data.daily.first {
                DayNigthView(weather: date)
            }
            
            //Hourly weather section
            ScrollView (showsIndicators: false){
                ForEach(0 ..< 12) { index in
                    WeatherRowView(weather: data.hourly[index])
                }
            }
            .padding()
            
            Spacer()
        }
    }
    
}
