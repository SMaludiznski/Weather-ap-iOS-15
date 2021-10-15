//
//  PlacesView.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 11/10/2021.
//

import SwiftUI

struct PlacesView: View {
    
    @ObservedObject private var settings = Settings()
    @StateObject private var vm = PlacesViewModel()
    @State var showAddCityView: Bool = false
    
    var body: some View {
        
        VStack {
            Text("WEATHER TODAY")
                .frame(maxWidth: .infinity)
                .font(.system(size: 15, weight: .light, design: .rounded))
                .padding(.bottom, 1)
                .overlay(
                    Button(action: {
                        showAddCityView.toggle()
                    }, label: {
                        Image(systemName: "location")
                            .font(.system(size: 25, weight: .semibold))
                            .padding(.horizontal, 15)
                    })
                    , alignment: .topTrailing)
            
            
            //check for fetch data result
            switch vm.state {
            case .loading: progressView
            case .failed(let error): FetchDataErrorView(errorText: error.localizedDescription)
            case .success(let data): getCurrentWeatherView(data: data)
            default: EmptyView()
            }
            
            Spacer()
            
            if !vm.cities.isEmpty {
                navigationView()
            }
            
            Spacer()
            Spacer()
        }
        .sheet(isPresented: $showAddCityView) {
            AddCityView()
        }
        .task {
            await vm.getCityWeather()
        }
    }
}

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesView()
    }
}

extension PlacesView {
    
    //City name and description
    private func header(cityName: String, description: String?) -> some View {
        VStack {
            HStack {
                Spacer()
                
                Text(cityName)
                    .font(.system(size: 25, weight: .light, design: .rounded))
                
                Spacer()
            }
            .font(.title2)
            
            if let description = description {
                Text(description.capitalizedFirstLetter())
                    .bold()
                    .font(.system(size: 16))
            }
        }
    }
    
    //Temperature View
    private func getTemp(temp: String, feels_like: String) -> some View {
        VStack (spacing: 0) {
            Text(temp)
                .font(.system(size: 120, weight: .ultraLight, design: .rounded))
                .overlay(
                    Text("Real feel \(feels_like)")
                        .font(.footnote)
                    , alignment: .bottomTrailing
                )
        }
        .padding()
    }
    
    //Weather view
    private func getCurrentWeatherView(data: CurrentWeatherModel) -> some View {
        VStack (spacing: 15) {
            header(cityName: vm.cities[vm.cityIndex], description: data.weather.first?.description)
            
            
            getTemp(temp: settings.getTemp(data.main.temp), feels_like: settings.getTemp(data.main.feels_like))
                .padding(.bottom, 20)
            
            VStack (spacing: 20) {
                customLabel(title: "Humidity", value: "\(data.main.humidity)" + "%")
                customLabel(title: "Wind Speed", value: "\(settings.getSpeed(data.wind.speed))")
                customLabel(title: "Clouds", value: "\(data.clouds.all)" + "%")
                customLabel(title: "Pressure", value: "\(data.main.pressure)" + " Pa")
            }
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: UIScreen.main.bounds.height / 2)
        .padding(8)
        .foregroundColor(Color.theme.font)
        
    }
    
    //Blue buttons navigation view
    private func navigationView() -> some View {
        HStack {
            Button {
                if vm.cityIndex > 0 {
                    vm.cityIndex -= 1
                    Task {
                        await vm.getCityWeather()
                    }
                }
            } label: {
                Image(systemName: "chevron.left")
                    .citiesNavigation()
            }
            
            Text("\(vm.cityIndex + 1)")
                .citiesNavigation()
            
            Button {
                if vm.cityIndex < vm.cities.count - 1 {
                    vm.cityIndex += 1
                    Task {
                        await vm.getCityWeather()
                    }
                }
            } label: {
                Image(systemName: "chevron.right")
                    .citiesNavigation()
            }
        }
    }
    
    //label used in weather view
    private func customLabel(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .italic()
            Spacer()
            Text(value)
        }
        .frame(maxWidth: 300)
        .font(.title3)
    }
    
    private var progressView: some View {
        ProgressCircleView()
            .frame(minHeight: UIScreen.main.bounds.height / 2)
    }
}
