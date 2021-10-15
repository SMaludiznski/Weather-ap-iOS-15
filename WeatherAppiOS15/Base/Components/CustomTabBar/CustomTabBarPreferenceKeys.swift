//
//  CustomTabBarPreferenceKeys.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 11/10/2021.
//

import Foundation
import SwiftUI

struct CustomTabViewPreferenceKey: PreferenceKey {
    
    static var defaultValue: [TabItemModel] = []
    
    static func reduce(value: inout [TabItemModel], nextValue: () -> [TabItemModel]) {
        value += nextValue()
    }
}

struct CustomTabViewPreferenceKeyViewModifier: ViewModifier {
    
    let tab: TabItemModel
    @Binding var selcetion: TabItemModel
    
    func body(content: Content) -> some View {
        content
            .opacity(selcetion == tab ? 1.0 : 0.0)
            .preference(key: CustomTabViewPreferenceKey.self, value: [tab])
    }
}

extension View {
    func tabBarItem(_ tab: TabItemModel, selection: Binding<TabItemModel>) -> some View {
        modifier(CustomTabViewPreferenceKeyViewModifier(tab: tab, selcetion: selection))
    }
}
