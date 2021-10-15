//
//  MainWeatherModel.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 12/10/2021.
//

import Foundation

struct MainWeatherModel: Codable {
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
}

struct Current: Codable {
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feels_like: Double
    let humidity: Int
    let clouds: Int
    let wind_speed: Double
}

struct Hourly: Codable {
    let dt: Int
    let temp: Double
    let weather: [Weather]
}

struct Weather: Codable {
    let icon: String
    let description: String
}

struct Daily: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Temp
    let humidity: Int
    let wind_speed: Double
    let weather: [Weather]
    let clouds: Int
    let rain: Double?
}

struct Temp: Codable {
    let day: Double
    let night: Double
}
