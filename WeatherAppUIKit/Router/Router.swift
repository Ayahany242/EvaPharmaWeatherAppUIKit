//
//  SplashScreenRouter.swift
//  WeatherAppUIKit
//
//  Created by AYA on 22/07/2024.
//

import Foundation
import UIKit

class SplashScreenRouter: SplashPresenterToRouterProtocol {
    weak var viewController: UIViewController?

    static func createModule(ref: SplashScreenViewController) {
        let view = ref
        let presenter = SplashScreenPresenter()
        let router = SplashScreenRouter()
        
        view.presenterObj = presenter
        presenter.router = router
        router.viewController = view
        
    }
    
    func navigateToCitiesScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let citiesVC = storyboard.instantiateViewController(withIdentifier: "CitiesViewController") as? CitiesViewController {
            let navigationController = UINavigationController(rootViewController: citiesVC)
            viewController?.view.window?.rootViewController = navigationController
            viewController?.view.window?.makeKeyAndVisible()
        }
    }
    
}

class Router:CitiesPresenterToRouterProtocol{
     var viewController: UIViewController?
    
    static func createCitiesModule(ref: CitiesViewController) {
        let view = ref
        let presenter = Presenter()
        let interactor = Interactor()
        let router = Router()
        
        view.presenterObj = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.interactor?.presenter = presenter
        router.viewController = view
        print("Createdddd")
    }
    func navigateToCityDetailsScreen(cityVC:FavoriteCityDelegation,cityData:CityCellData,index:Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let cityDetailVC = storyboard.instantiateViewController(withIdentifier: "CityDetailsViewController") as? CityDetailsViewController {
            cityDetailVC.delegate = cityVC
            cityDetailVC.city = cityData
            cityDetailVC.index = index
            viewController?.navigationController?.pushViewController(cityDetailVC, animated: true)
        }
    }
    
}
