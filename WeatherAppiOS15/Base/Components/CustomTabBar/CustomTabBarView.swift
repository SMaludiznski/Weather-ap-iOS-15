//
//  CustomTabBarView.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 11/10/2021.
//

import SwiftUI

struct CustomTabBarView: View {
    
    @Binding var selection: TabItemModel
    let tabs: [TabItemModel]
    @Namespace private var namespace
    
    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { item in
                tabBarItem(item)
                    .onTapGesture {
                        changeSelection(item)
                    }
            }
        }
        .padding(4)
        .background(Color.theme.background)
        .frame(maxWidth: .infinity)
        .ignoresSafeArea(edges: .bottom)
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        VStack {
            Spacer()
            CustomTabBarView(selection: .constant(.weather), tabs: [
                TabItemModel.weather,
                TabItemModel.places,
                TabItemModel.news,
                TabItemModel.settings
            ])
        }
    }
}

extension CustomTabBarView {
    private func tabBarItem(_ tabItem: TabItemModel) -> some View {
        VStack (spacing: 3) {
            Image(systemName: tabItem.icon)
                .font(.title2)
            Text(tabItem.title)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .foregroundColor(selection == tabItem ? Color.theme.accent : Color.theme.font)
        .background(
            ZStack {
                if selection == tabItem {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.theme.accent.opacity(0.2))
                        .matchedGeometryEffect(id: "background_rectangle", in: namespace)
                }
            }
        )
    }
    
    func changeSelection(_ tabItem: TabItemModel) {
        withAnimation(.easeInOut) {
            selection = tabItem
        }
    }
}
