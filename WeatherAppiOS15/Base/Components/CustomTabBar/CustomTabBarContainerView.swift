//
//  CustomTabBarContainerView.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 11/10/2021.
//

import SwiftUI

struct CustomTabBarContainerView<Content: View>: View {
    
    let content: Content
    @Binding var selection: TabItemModel
    @State private var tabs: [TabItemModel] = []
    
    init(selection: Binding<TabItemModel>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        ZStack (alignment: .top) {
            content
            
            VStack {
                Spacer()
                CustomTabBarView(selection: $selection, tabs: tabs)
            }
        }
        .onPreferenceChange(CustomTabViewPreferenceKey.self) { value in
            tabs = value
        }
    }
}

struct CustomTabBarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarContainerView(selection: .constant(.weather)) {
            
        }
    }
}
