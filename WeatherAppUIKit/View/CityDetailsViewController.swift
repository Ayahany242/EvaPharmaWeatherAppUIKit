//
//  CityDetailsViewController.swift
//  WeatherAppUIKit
//
//  Created by AYA on 22/07/2024.
//

import UIKit

class CityDetailsViewController: UIViewController {
    var city:CityCellData?
    var delegate: FavoriteCityDelegation?
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var humadityLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var weatherStateLabel: UILabel!
    
    @IBOutlet weak var viewBorder: UIView!
    var index:Int?
    var isFav:Bool? = false
    
    var image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage()
        viewBorder.layer.borderWidth = 1.0
        viewBorder.layer.cornerRadius = 10
        viewBorder.layer.borderColor = UIColor.blue.cgColor
        
        image?.withTintColor(UIColor.systemYellow)
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpData()
        setupNavigationBar()
    }
    private func setupNavigationBar() {
        image = isFav! ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        
        let barButtonItem = UIBarButtonItem(image: image ?? UIImage(systemName: "star"), style: .plain, target: self, action: #selector(favButtonTapped))
        navigationItem.setRightBarButton(barButtonItem, animated: true)
        //self.navigationItem.rightBarButtonItem = barButtonItem
    }
    @objc private func favButtonTapped() {
        print("Index = \(index)")
        isFav = !isFav!
        image = isFav! ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        self.navigationItem.rightBarButtonItem?.image = image
        
        delegate?.isFavorite(isFav: isFav!, index: index ?? 0)
    }
    
    @IBAction func tapped(_ sender: UIButton) {
        print("Index = \(index)")
        delegate?.isFavorite(isFav: true, index: index ?? 0)
        
    }
    
    private func setUpData(){
        guard let city = city else {
            return
        }
        isFav = city.isFav
        cityLabel.text = city.cityName
        tempLabel.text = "\(city.weather?.current?.apparentTemperature ?? 0)\(city.weather?.currentUnits?.apparentTemperature ?? "°C")"
        humadityLabel.text = "\(city.weather?.current?.relativeHumidity2M ?? 0)\(city.weather?.currentUnits?.relativeHumidity2M ?? "%")"
        visibilityLabel.text = "\(city.weather?.current?.visibility ?? 0)\(city.weather?.currentUnits?.visibility ?? "m")"
        windSpeedLabel.text = "\(city.weather?.current?.windSpeed ?? 0)\(city.weather?.currentUnits?.windSpeedM ?? "km/h")"
        weatherStateLabel.text = "\(city.weather?.current?.rain ?? 0)\(city.weather?.currentUnits?.rain ?? "mm")"
        weatherIcon.image = UIImage(named: WeatherIcon.getIcon(for: city.weather?.current?.weatherCode ?? 0))
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    private func setupBackgroundImage() {
        let backgroundImageView = UIImageView(frame: self.view.bounds)
        backgroundImageView.image = UIImage(named: "bg")
        backgroundImageView.contentMode = .scaleAspectFill
        
        self.view.addSubview(backgroundImageView)
        self.view.sendSubviewToBack(backgroundImageView)
    }
}
