//
//  FetchDataService.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 12/10/2021.
//

import Foundation
import UIKit

final class FetchDataService {
    
    static let instance = FetchDataService()
    private init() { }
    
    //Download data from the internet
    func fetchData<T: Codable>(url: String) async throws -> T {
        guard let url = URL(string: url) else { throw FetchDataErrors.wrongURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
                  throw FetchDataErrors.wrongServerResponse
              }
        
        do {
            let decodedT = try JSONDecoder().decode(T.self, from: data)
            return decodedT
        } catch {
            throw FetchDataErrors.dataDecodingError
        }
    }
    
    //Download image from the internet
    func fetchImage(url: String) async throws -> UIImage {
        guard let url = URL(string: url) else { throw FetchDataErrors.wrongURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
                  throw FetchDataErrors.wrongServerResponse
              }
        
        guard let image = UIImage(data: data) else {
            throw FetchDataErrors.dataDecodingError
        }
        return image
    }
}
