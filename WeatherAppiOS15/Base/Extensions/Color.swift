//
//  ContentView.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 11/10/2021.
//

import SwiftUI

extension Color {
    static let theme = Theme()
}

struct Theme {
    let font: Color = Color("Font")
    let background: Color = Color("Background")
    let accent: Color = Color("AccentColor")
}
