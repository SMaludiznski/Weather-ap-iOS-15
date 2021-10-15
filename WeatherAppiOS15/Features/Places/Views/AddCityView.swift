//
//  AddCityView.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 14/10/2021.
//

import SwiftUI

struct AddCityView: View {
    
    @ObservedObject private var vm = PlacesViewModel()
    @FocusState private var cityNameIsFocused: Bool
    
    var body: some View {
        VStack {
            HStack {
                TextField("Add new city", text: $vm.cityName)
                    .font(.title2)
                    .focused($cityNameIsFocused)
                    .submitLabel(.done)
                    .onSubmit {
                        if !vm.cityName.isEmpty {
                            vm.addCity(cityName: vm.cityName)
                            cityNameIsFocused = false
                            vm.cityName = ""
                        }
                    }
                Image(systemName: "plus.circle")
                    .font(.largeTitle)
                    .foregroundColor(Color.theme.accent)
                    .onTapGesture {
                        if !vm.cityName.isEmpty {
                            vm.addCity(cityName: vm.cityName)
                            cityNameIsFocused = false
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
