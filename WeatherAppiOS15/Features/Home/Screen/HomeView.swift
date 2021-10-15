//
//  HomeView.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 11/10/2021.
//

import SwiftUI

struct HomeView: View {
    
    @State private var selection: TabItemModel = .weather
    
    var body: some View {
        ZStack {
            //background
            Color.theme.background.ignoresSafeArea()
            
            //foreground
            CustomTabBarContainerView(selection: $selection) {
                WeatherView()
                    .tabBarItem(.weather, selection: $selection)
                
                PlacesView()
                    .tabBarItem(.places, selection: $selection)
                
                NewsView()
                    .tabBarItem(.news, selection: $selection)
                
                SettingsView()
                    .tabBarItem(.settings, selection: $selection)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
