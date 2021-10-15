//
//  NewsImageView.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 12/10/2021.
//

import SwiftUI

struct NewsImageView: View {
    
    @StateObject private var vm: NewsImageViewModel = NewsImageViewModel()
    let url: String?
    
    var body: some View {
        
        if let url = url {
            VStack {
                switch vm.state {
                case .failed: imageError
                case .loading: getProgressView()
                case .success(let image): getImage(image: image)
                default: EmptyView()
                }
            }
            .task {
                await vm.getImage(url: url)
            }
        } else {
            EmptyView()
        }
    }
}

struct NewsImageView_Previews: PreviewProvider {
    static var previews: some View {
        NewsImageView(url: NewsModel.new.urlToImage)
    }
}

extension NewsImageView {
    private var imageError: some View {
        VStack (alignment: .center, spacing: 10) {
            Image(systemName: "xmark")
                .font(.title)
            Text("No image here")
        }
        .foregroundColor(Color.theme.font)
        .newsImage()
    }
    
    private func getImage(image: UIImage) -> some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .newsImage()
    }
    
    private func getProgressView() -> some View {
        ProgressView()
            .newsImage()
    }
}
