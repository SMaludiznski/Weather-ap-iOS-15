//
//  TabItemModel.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 11/10/2021.
//

import Foundation
import SwiftUI

enum TabItemModel: Hashable {
    case weather, places, news, settings
    
    var title: String {
        switch self {
        case .weather: return "Weather"
        case .places: return "Places"
        case .news: return "News"
        case .settings: return "Settings"
        }
    }
    
    var icon: String {
        switch self {
        case .weather: return "cloud.sun"
        case .places: return "map"
        case .news: return "newspaper"
        case .settings: return "gearshape"
        }
    }
}
