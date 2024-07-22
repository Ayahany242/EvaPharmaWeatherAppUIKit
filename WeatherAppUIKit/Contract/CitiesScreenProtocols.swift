//
//  CitiesScreenProtocols.swift
//  WeatherAppUIKit
//
//  Created by AYA on 22/07/2024.
//

import Foundation
import UIKit


protocol CitiesViewToPresenterProtocol{
    func showCitiesData(cities:[City])
    func showError(_ message: String)
    var view: CitiesPresenterToViewProtocol? { get set }
    var interactor: CitiesPresenterToInteractorProtocol? { get set }
    func navigateToCitiesDetails(cityVC:FavoriteCityDelegation,cityData:CityCellData,index:Int)
}

protocol CitiesPresenterToInteractorProtocol{
    var presenter: CitiesInteractorToPresenterProtocol? {get set}
    func fetchWeatherData(cities:[City])
}

protocol CitiesPresenterToViewProtocol{
    func sendDataToView(result: CitiesWeatherModel)
    func showErrorMessage(error:String)
}

protocol CitiesInteractorToPresenterProtocol{
    func sendDataToPresenter(result: CitiesWeatherModel)
    func FailToFetchWeatherData(error: Error)
}

protocol CitiesPresenterToRouterProtocol{
    func navigateToCityDetailsScreen(cityVC:FavoriteCityDelegation,cityData:CityCellData,index:Int)
    var viewController: UIViewController? { get set }
    static func createCitiesModule(ref: CitiesViewController)
   // static func createCityDetailsModule(ref: CitiesTableViewController)
}
