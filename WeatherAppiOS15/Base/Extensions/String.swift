//
//  String.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 13/10/2021.
//

import Foundation

extension String {
    func capitalizedFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
