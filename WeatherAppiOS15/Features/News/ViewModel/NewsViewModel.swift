//
//  NewsViewModel.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 12/10/2021.
//

import Foundation
import SwiftUI

@MainActor
final class NewsViewModel: ObservableObject {
    
    enum NewsState {
        case na
        case failed(error: Error)
        case success(data: NewsModel)
        case loading
    }
    
    @Published private(set) var news: NewsModel?
    @Published private(set) var state: NewsState = .na
    
    func getNews() async {
        state = .loading
        
        do {
            let posts: NewsModel = try await FetchDataService.instance.fetchData(url: Constants.newsAPIURL)
            state = .success(data: posts)
            
        } catch {
            state = .failed(error: error)
        }
    }
}
