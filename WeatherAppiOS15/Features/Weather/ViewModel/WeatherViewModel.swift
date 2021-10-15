//
//  WeatherViewModel.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 12/10/2021.
//
import Foundation
import CoreLocation

@MainActor
final class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    enum WeatherState {
        case na
        case failed(error: Error)
        case success(data: MainWeatherModel)
        case loading
    }
    
    enum LocationState {
        case failed(error: String)
        case success
    }
    
    @Published private(set) var state: WeatherState = .na
    @Published private(set) var locationState: LocationState = .failed(error: "Turn on location service.")
    @Published private(set) var userCoordinate: CLLocationCoordinate2D?
    
    var locationManager: CLLocationManager?
    
    func getWeather() async {
            state = .loading
            checkIfLocationServiceIsEnabled()
            do {
                if let coordinates = locationManager?.location?.coordinate {
                    let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(Constants.weatherAPIKey)&units=metric"
                    
                    let returnedWeather: MainWeatherModel = try await FetchDataService.instance.fetchData(url: url)
                    state = .success(data: returnedWeather)
                } else {
                    Task {
                        await getWeather()
                    }
                }
            } catch {
                state = .failed(error: error)
            }
    }
    
    func checkIfLocationServiceIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        } else {
            locationState = .failed(error: "You need turn on location service.")
        }
    }
    
    private func checkLocationAuthorizationStatus() {
        guard let locationManager = locationManager else {
            return
        }

        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            locationState = .failed(error: "Your location is restricted likely due to parental controls.")
        case .denied:
            locationState = .failed(error: "Yoy have denied this app location permission.")
        case .authorizedAlways, .authorizedWhenInUse:
            locationState = .success
            userCoordinate = locationManager.location?.coordinate
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorizationStatus()
    }
}
