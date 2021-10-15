//
//  AddCityView.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 14/10/2021.
//

import SwiftUI

struct AddCityView: View {
    
    @ObservedObject private var vm = PlacesViewModel()
    
    var body: some View {
        VStack {
            HStack {
                TextField("Add new city", text: $vm.cityName)
                    .font(.title2)
                Image(systemName: "plus.circle")
                    .font(.largeTitle)
                    .foregroundColor(Color.theme.accent)
                    .onTapGesture {
                        if !vm.cityName.isEmpty {
                            vm.addCity(cityName: vm.cityName)
                            vm.cityName = ""
                        }
                    }
            }
            .padding()
            
            List {
                ForEach(vm.cities, id: \.self) { city in
                    Text(city)
                        .font(.title2)
                        .padding(.vertical, 15)
                }
                .onDelete(perform: removeItem)
            }
            .listStyle(PlainListStyle())
        }
        .padding()
    }
    
    private func removeItem(_ index: IndexSet) {
        vm.cities.remove(atOffsets: index)
        UserDefaults.standard.set(vm.cities, forKey: "cities")
    }
}

struct AddCityView_Previews: PreviewProvider {
    static var previews: some View {
        AddCityView()
    }
}
