//
//  CacheManager.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 12/10/2021.
//

import Foundation
import UIKit

final class CacheManager {
    
    static let instance = CacheManager()
    private init() {}
    
    //Image cache manger
    var imageCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 50
        cache.totalCostLimit = 1024 * 1024 * 200
        return cache
    }()
    
    func addImage(name: String, image: UIImage) {
        imageCache.setObject(image, forKey: name as NSString)
    }
    
    func getImage(name: String) -> UIImage? {
        if let image = imageCache.object(forKey: name as NSString) {
            return image
        } else {
            return nil
        }
    }
    
    //Current weather list cache manager
    var currentWeatherListCache: NSCache<NSString, CurrentWeatherModel> = {
       let cache = NSCache<NSString, CurrentWeatherModel>()
        cache.countLimit = 15
        cache.totalCostLimit = 150 * 1024 * 1024
        return cache
    }()
    
    func addCityToCache(name: String, obj: CurrentWeatherModel) {
        currentWeatherListCache.setObject(obj, forKey: name as NSString)
    }
    
    func getCityFromCache(name: String) -> CurrentWeatherModel? {
        if let city = currentWeatherListCache.object(forKey: name as NSString) {
            return city
        } else {
            return nil
        }
    }
    
}
