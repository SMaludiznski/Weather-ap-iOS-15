//
//  CitiesErrors.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 14/10/2021.
//

import SwiftUI

enum CitiesErrors: LocalizedError {
    case citiesEmpty
    
    public var errorDescription: String? {
        switch self {
        case .citiesEmpty: return NSLocalizedString("You need to add some locations!", comment: "")
        }
    }
}
