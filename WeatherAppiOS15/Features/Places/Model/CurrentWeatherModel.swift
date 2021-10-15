//
//  CurrentWeatherModel.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 14/10/2021.
//

import Foundation

class CurrentWeatherModel: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
}

struct Wind: Codable {
    let speed: Double
}

struct Clouds: Codable {
    let all: Int
}
