//
//  NewsRowView.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 12/10/2021.
//

import SwiftUI

struct NewsRowView: View {
    
    let news: Articles
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack (alignment: .center) {
                VStack (alignment: .leading) {
                    Text(news.title ?? "")
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                    Text(news.author ?? "Unknown")
                        .font(.footnote)
                        .italic()
                        .foregroundColor(.secondary)
                }
                .padding(10)
                
                Spacer()
                NewsImageView(url: news.urlToImage)
                    .padding(.horizontal, 10)
            }
            .padding(.vertical, 15)
            Divider()
        }
    }
}

struct NewsRowView_Previews: PreviewProvider {
    static var previews: some View {
        NewsRowView(news: NewsModel.new)
            .padding()
    }
}
