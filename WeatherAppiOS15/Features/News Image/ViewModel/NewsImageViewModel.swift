//
//  NewsImageViewModel.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 12/10/2021.
//

import Foundation
import SwiftUI

@MainActor
final class NewsImageViewModel: ObservableObject {
    
    enum ImageState {
        case na
        case failed
        case success(image: UIImage)
        case loading
    }
    
    @Published private(set) var state: ImageState = .na
    private let cache = CacheManager.instance
    
    
    func getImage(url: String) async {
        state = .loading
        if let image = cache.getImage(name: url) {
            state = .success(image: image)
        } else {
            do {
                let returnedImage = try await FetchDataService.instance.fetchImage(url: url)
                state = .success(image: returnedImage)
                cache.addImage(name: url, image: returnedImage)
            } catch {
                state = .failed
            }
        }
    }
}
