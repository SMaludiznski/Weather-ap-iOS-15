//
//  FetchDataProgressView.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 13/10/2021.
//

import SwiftUI

struct FetchDataProgressView: View {
    
    var body: some View {
        VStack (spacing: 10) {
            
            ProgressCircleView()
            Text("Give me a moment...")
                .foregroundColor(Color.theme.accent)
                .font(.title2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct FetchDataProgressView_Previews: PreviewProvider {
    static var previews: some View {
        FetchDataProgressView()
    }
}


struct ProgressCircleView: View {
    
    @State private var isAnimating = false
    @State private var showProgress = false
    var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        Image(systemName: "arrow.2.circlepath")
            .font(.system(size: 30, weight: .semibold))
            .frame(width: 50, height: 50)
            .foregroundColor(Color.theme.accent)
            .rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0.0))
            .animation(self.isAnimating ? foreverAnimation : .default)
            .onAppear { self.isAnimating = true }
            .onDisappear { self.isAnimating = false }
    }
}
