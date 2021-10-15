//
//  NewsView.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 11/10/2021.
//

import SwiftUI

struct NewsView: View {
    
    @StateObject private var vm: NewsViewModel = NewsViewModel()
    
    var body: some View {
        VStack {

            switch vm.state {
            case .loading: FetchDataProgressView()
            case .failed(let error): FetchDataErrorView(errorText: error.localizedDescription)
            case .success(let data): listOfNews(data: data)
            default: EmptyView()
            }
            
            Spacer()
        }
        .task {
            await vm.getNews()
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}

extension NewsView {
    private var header: some View {
        HStack {
            Spacer()
            Image(systemName: "newspaper")
            Text("NEWS")
            Spacer()
        }
        .padding(.top, 10)
        .font(.system(size: 27, weight: .light, design: .rounded))
    }
    
    
    private func listOfNews(data: NewsModel) -> some View {
        VStack (alignment: .leading) {
            header
            
            ScrollView {
                ForEach(data.articles, id: \.self) { item in
                    if item.title != nil {
                        Link(destination: URL(string: item.url)!) {
                            NewsRowView(news: item)
                            
                        }
                    }
                }
            }
        }
        .accentColor(Color.primary)
        .listStyle(PlainListStyle())
    }
}

