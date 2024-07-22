//
//  Presenter.swift
//  WeatherAppUIKit
//
//  Created by AYA on 22/07/2024.
//

import Foundation

class Presenter:CitiesViewToPresenterProtocol{
    func navigateToCitiesDetails(cityVC:FavoriteCityDelegation,cityData:CityCellData,index:Int) {
        router?.navigateToCityDetailsScreen(cityVC: cityVC, cityData: cityData, index: index)
    }
    
    var router :CitiesPresenterToRouterProtocol?

    func showError(_ message: String) {
        view?.showErrorMessage(error: message)
    }
    
    func showCitiesData(cities: [City]) {
        interactor?.fetchWeatherData(cities: cities)
        print("Show Citiessss Presenter")
    }
    
    
    var view: CitiesPresenterToViewProtocol?
    
    var interactor: CitiesPresenterToInteractorProtocol?
}

extension Presenter : CitiesInteractorToPresenterProtocol{
    func sendDataToPresenter(result: CitiesWeatherModel) {
        print("data at sendDataToPresenter call sendDataToView")
        view?.sendDataToView(result: result)
    }
    
    func FailToFetchWeatherData(error: Error) {
        view?.showErrorMessage(error: error.localizedDescription)
    }
    
}
