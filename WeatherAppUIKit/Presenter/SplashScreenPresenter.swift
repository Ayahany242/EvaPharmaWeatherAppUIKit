//
//  SplashScreenPresenter.swift
//  WeatherAppUIKit
//
//  Created by AYA on 22/07/2024.
//

import Foundation
class SplashScreenPresenter: SplashViewToPresenterProtocol {
    
    var router :SplashPresenterToRouterProtocol?
    
    func setUpSplashTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.router?.navigateToCitiesScreen()
        }
    }
}
