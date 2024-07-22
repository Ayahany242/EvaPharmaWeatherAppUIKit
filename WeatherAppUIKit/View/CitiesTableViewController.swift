//
//  CitiesTableViewController.swift
//  WeatherAppUIKit
//
//  Created by AYA on 22/07/2024.
//

import UIKit

class CitiesTableViewController: UITableViewController {
    private let cities:[City] = [City(cityName: "Cairo", lat: 30.06263, long: 31.24967),City(cityName: "Tokyo", lat: 35.6895    , long: 139.69171    ),City(cityName: "Madrid", lat: 40.4165    , long: -3.70256),City(cityName: "Lagos", lat: 6.45407, long: 3.39467    ),City(cityName: "Moscow", lat: 55.75222, long: 37.61556    )]

    var presenterObj:CitiesViewToPresenterProtocol?
    var citiesData: CitiesWeatherModel = []
    var isFav:Bool? = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CityWeatherTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CityWeatherTableViewCell")
        //Router.createCitiesModule(ref: self)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenterObj?.showCitiesData(cities: cities)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cities"
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return citiesData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityWeatherTableViewCell", for: indexPath) as! CityWeatherTableViewCell
        let data = CityCellData(cityName: cities[indexPath.row].cityName ?? "Ismailia", weather: citiesData[indexPath.row],isFav: isFav)
        cell.setData(city: data)
        return cell
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
     
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

extension CitiesTableViewController:CitiesPresenterToViewProtocol{
    func sendDataToView(result: CitiesWeatherModel) {
        print("result at table View \(result)")
        self.citiesData = result
        tableView.reloadData()
    }
    
    func showErrorMessage(error: String) {
        print("Error")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data = CityCellData(cityName: cities[indexPath.row].cityName ?? "Ismailia", weather: citiesData[indexPath.row],isFav: isFav)
        self.presenterObj?.navigateToCitiesDetails(cityData: data)
    }
    
}
