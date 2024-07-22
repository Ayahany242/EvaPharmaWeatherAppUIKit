//
//  Interactor.swift
//  WeatherAppUIKit
//
//  Created by AYA on 22/07/2024.
//

import Foundation

class Interactor:CitiesPresenterToInteractorProtocol{
    var presenter: CitiesInteractorToPresenterProtocol?
    
    func fetchWeatherData(cities: [City]) {
        print("Fetch Cities at interactor")
        NetworkService.shared.fetchWeatherData(cities: cities) {[weak self] result in
            switch result{
            case .success(let citiesData):
                DispatchQueue.main.async {
                    self?.presenter?.sendDataToPresenter(result: citiesData)
                  
                }
                print("Fetch Cities at interactor success")
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.FailToFetchWeatherData(error: error)
                }
                print("Fetch Cities at interactor failed")
            }
        }
    }
}
