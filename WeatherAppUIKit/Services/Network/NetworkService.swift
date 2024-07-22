//
//  NetworkService.swift
//  WeatherAppUIKit
//
//  Created by AYA on 22/07/2024.
//

import Foundation

protocol NetworkServiceProtocol{
    func fetchWeatherData(cities: [City] ,completion: @escaping (Result<CitiesWeatherModel, Error>) -> Void)
}

class NetworkService:NetworkServiceProtocol{
    static let shared = NetworkService()
    private init() {}
    func fetchWeatherData(cities: [City], completion: @escaping (Result<CitiesWeatherModel, Error>) -> Void) {
        var lat = ""
        var long = ""
        for city in cities{
            lat.append("\(city.lat ?? 0),")
            long.append("\(city.long ?? 0),")
        }
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(lat)&longitude=\(long)&current=temperature_2m,relative_humidity_2m,apparent_temperature,weather_code,rain,wind_speed_10m,visibility"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkErrors.invalidUrl))
            return
        }
        let urlRequest = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("failed network at task \(error)")

                return
            }
            guard let data = data else {
                completion(.failure(NetworkErrors.networkConnectionError(err: "No data received")))
                print("failed network No data received")
                return
            }
            do {
               
                let citiesWeather = try JSONDecoder().decode(CitiesWeatherModel.self, from: data)
                //print("Data response \(citiesWeather)")
                completion(.success(citiesWeather))
            } catch {
                completion(.failure(error))
                print("failed network catch \(error)")
            }
        }
        task.resume()

    }
}

enum NetworkErrors: Error {
  case invalidUrl
  case networkConnectionError(err: String?)
}
