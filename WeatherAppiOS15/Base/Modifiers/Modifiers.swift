//
//  Modifiers.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 12/10/2021.
//

import SwiftUI

struct CitiesNavigationButton: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .bold))
            .frame(width: 35, height: 35)
            .foregroundColor(Color.white)
            .background(Color.theme.accent)
            .cornerRadius(5)
    }
}

struct ImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 100, height: 100)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 6, x: 1, y: 3)
    }
}

extension View {
    func citiesNavigation() -> some View {
        modifier(CitiesNavigationButton())
    }
    
    func newsImage() -> some View {
        modifier(ImageModifier())
    }
}
