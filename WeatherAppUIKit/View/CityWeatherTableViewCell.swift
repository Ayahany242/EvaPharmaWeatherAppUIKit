//
//  CityWeatherTableViewCell.swift
//  WeatherAppUIKit
//
//  Created by AYA on 22/07/2024.
//

import UIKit

class CityWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var FavIcon: UIImageView!
    @IBOutlet weak var TempLabel: UILabel!
    @IBOutlet weak var CityNameLabel: UILabel!
    @IBOutlet weak var viewBorder: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewBorder.layer.borderWidth = 1.0
        viewBorder.layer.borderColor = UIColor.blue.cgColor
        viewBorder.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(city:CityCellData){
        CityNameLabel.text = city.cityName
        TempLabel.text = "\(city.weather?.current?.apparentTemperature ?? 0)\(city.weather?.currentUnits?.temperature2M ?? "°C")"
        let icon = city.isFav ?? false ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        FavIcon.image = icon
    }
    
}
