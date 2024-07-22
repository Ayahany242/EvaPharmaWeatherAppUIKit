//
//  CitiesViewController.swift
//  WeatherAppUIKit
//
//  Created by AYA on 22/07/2024.
//

import UIKit

class CitiesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var failedLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
  
    
    private let cities:[City] = [City(cityName: "Cairo", lat: 30.06263, long: 31.24967),City(cityName: "Tokyo", lat: 35.6895    , long: 139.69171    ),City(cityName: "Madrid", lat: 40.4165    , long: -3.70256),City(cityName: "Lagos", lat: 6.45407, long: 3.39467    ),City(cityName: "Moscow", lat: 55.75222, long: 37.61556    )]

    var presenterObj:CitiesViewToPresenterProtocol?
    var citiesData: CitiesWeatherModel = []
    var citiesDataCell: [CityCellData] = []
    
    var isFav:Bool? = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        Router.createCitiesModule(ref: self)
        indicator.startAnimating()
        presenterObj?.showCitiesData(cities: cities)
    }
    private func setUp(){
        let nib = UINib(nibName: "CityWeatherTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CityWeatherTableViewCell")
        setupBackgroundImage()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        failedLabel.isHidden = true
        //tableView.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        indicator.startAnimating()
//        presenterObj?.showCitiesData(cities: cities)
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cities"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return citiesDataCell.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityWeatherTableViewCell", for: indexPath) as! CityWeatherTableViewCell
        //let data = CityCellData(cityName: cities[indexPath.row].cityName ?? "Ismailia", weather: citiesData[indexPath.row],isFav: isFav)
        cell.setData(city: citiesDataCell[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        //headerView.backgroundColor = .lightGray
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60)
        label.text = "Cities"
        label.font = UIFont(name: "Optima", size: 24)
        label.textColor = .black
        label.textAlignment = .center
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
     
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

}


extension CitiesViewController:CitiesPresenterToViewProtocol,FavoriteCityDelegation{
    func sendDataToView(result: CitiesWeatherModel) {
        print("result at table View \(result)")
        indicator.isHidden = true
        indicator.stopAnimating()
        failedLabel.isHidden = true
        self.citiesData = result
       // self.citiesDataCell = result
        for i in 0..<result.count{
            self.citiesDataCell.append(CityCellData(cityName: cities[i].cityName, weather: result[i], isFav: false))
        }
        tableView.reloadData()
    }
    
    func showErrorMessage(error: String) {
        indicator.isHidden = true
        indicator.stopAnimating()
        failedLabel.isHidden = false
        failedLabel.text = error
        tableView.isHidden = true
        print("Error")
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //let data = CityCellData(cityName: cities[indexPath.row].cityName ?? "Ismailia", weather: citiesData[indexPath.row],isFav: isFav)
        self.presenterObj?.navigateToCitiesDetails(cityVC: self, cityData: citiesDataCell[indexPath.row], index: indexPath.row)
    }
    
    func isFavorite(isFav: Bool,index:Int) {
        
        self.citiesDataCell[index].isFav = isFav
        print("citiesDataCell list \(citiesDataCell)")
        tableView.reloadData()
    }
    private func setupBackgroundImage() {
        let backgroundImageView = UIImageView(frame: self.view.bounds)
        backgroundImageView.image = UIImage(named: "bg")
        backgroundImageView.contentMode = .scaleAspectFill
        
        self.view.addSubview(backgroundImageView)
        self.view.sendSubviewToBack(backgroundImageView)
    }
}
