//
//  ViewController.swift
//  WeatherAppUIKit
//
//  Created by AYA on 22/07/2024.
//

import UIKit

class SplashScreenViewController: UIViewController{
    var presenterObj: SplashViewToPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        SplashScreenRouter.createModule(ref: self)
        presenterObj?.setUpSplashTimer()
    }


}

