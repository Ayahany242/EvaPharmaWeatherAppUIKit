//
//  SplashScreenProtocols.swift
//  WeatherAppUIKit
//
//  Created by AYA on 22/07/2024.
//

import Foundation

protocol SplashViewToPresenterProtocol{
    func setUpSplashTimer()
}

protocol SplashPresenterToRouterProtocol{
    func navigateToCitiesScreen()
    static func createModule(ref: SplashScreenViewController)
}
