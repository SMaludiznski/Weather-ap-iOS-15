//
//  PlacesViewModel.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 14/10/2021.
//

import Foundation
import SwiftUI

@MainActor
final class PlacesViewModel: ObservableObject {
    
    enum FetchWeatherState {
        case na
        case success(data: CurrentWeatherModel)
        case failed(error: Error)
        case loading
    }
    
    @Published var cityName: String = ""
    @Published var cityIndex: Int = 0
    @Published var cities: [String] = UserDefaults.standard.stringArray(forKey: "cities") ?? []
    @Published private(set) var state: FetchWeatherState = .na
    
    private var cacheManager = CacheManager.instance
    
    func addCity(cityName: String) {
        cities.append(cityName)
        UserDefaults.standard.set(cities, forKey: "cities")
    }
    
    func getCityWeather() async {
        state = .loading
        
        if !cities.isEmpty {
            //fristly try get weather from cache
            if let city = cacheManager.getCityFromCache(name: cities[cityIndex]) {
                state = .success(data: city)
            } else {
                do {
                    let url = "https://api.openweathermap.org/data/2.5/weather?q=\(cities[cityIndex])&appid=\(Constants.weatherAPIKey)&units=metric"
                    
                    //try get weather from network
                    let currentWeather: CurrentWeatherModel = try await FetchDataService.instance.fetchData(url: url)
                    //add weather to cache
                    cacheManager.addCityToCache(name: cities[cityIndex], obj: currentWeather)
                    state = .success(data: currentWeather)
                } catch {
                    state = .failed(error: error)
                }
            }
        } else {
            state = .failed(error: CitiesErrors.citiesEmpty)
        }
    }
}
