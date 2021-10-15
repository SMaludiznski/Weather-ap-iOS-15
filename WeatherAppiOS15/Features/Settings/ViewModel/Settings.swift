//
//  Settings.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 13/10/2021.
//

import Foundation
import SwiftUI

final class Settings: ObservableObject {
    
    @AppStorage("temperatureInC") var temperatureInC: Bool = true
    @AppStorage("windSpeedInKm") var windSpeedInKm: Bool = true
    
    
    func getTemp(_ value: Double) -> String {
        if temperatureInC {
            return String(format: "%.f", value) + "°"
        } else {
            let result = ((9 * value) / 5) + 32
            return String(format: "%.f", result) + "°"
        }
    }
    
    func getSpeed(_ speed: Double) -> String {
        if windSpeedInKm {
            let result = ((speed * 3600)/1000)
            return String(format: "%.f", result) + " km/h"
        } else {
            let result = ((speed * 3600)/1000) * 0.621371192
            return String(format: "%.f", result) +  " Mph"
        }
    }
    
    func getDayFromInt(_ number: Int) -> String {
        let timeInterval = TimeInterval(number)
        let newDate = Date(timeIntervalSince1970: timeInterval)
        
        let dataFormatter = DateFormatter()
        dataFormatter.dateStyle = .medium
        dataFormatter.timeStyle = .none
        
        return dataFormatter.string(from: newDate)
    }
    
    func getDateFromInt(_ number: Int) -> String {
        let timeInterval = TimeInterval(number)
        let newDate = Date(timeIntervalSince1970: timeInterval)
        
        let dataFormatter = DateFormatter()
        dataFormatter.dateStyle = .none
        dataFormatter.timeStyle = .short
        
        return dataFormatter.string(from: newDate)
    }
    
    func getImage(icon: String) -> String {
        switch icon {
        // day icons
        case "01d": return "sun.max"
        case "02d": return "cloud.sun.fill"
        case "03d", "03n": return "cloud.fill"
        case "04d", "04n": return "smoke.fill"
        case "09d", "09n": return "cloud.drizzle.fill"
        case "10d": return "cloud.sun.rain.fill"
        case "11d", "11n": return "cloud.bolt.fill"
        case "13d", "13n": return "snowflake"
        case "50d", "50n": return "cloud.fog.fill"
        
        // night icons
        case "01n": return "moon.fill"
        case "02n": return "cloud.moon"
        case "10n": return "cloud.moon.rain.fill"
        default: return "thermometer"
        }
    }
    
    func getVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        return version
    }
}
