//
//  FetchDataErrorView.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 13/10/2021.
//

import SwiftUI

struct FetchDataErrorView: View {
    
    let errorText: String
    
    var body: some View {
        VStack (spacing: 10) {
            Spacer()
            Image(systemName: "xmark.octagon")
                .font(.system(size: 60, weight: .light))
                
            Text(errorText)
                .frame(maxWidth: 300)
                .multilineTextAlignment(.center)
                .font(.title3)
            Spacer()
        }
        .foregroundColor(Color.red.opacity(0.8))
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height/2)
    }
}

struct FetchDataErrorView_Previews: PreviewProvider {
    static var previews: some View {
        FetchDataErrorView(errorText: "Your location is restricted likely due to parental controls.")
    }
}
