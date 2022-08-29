//
//  ViewController.swift
//  WeatherApp
//
//  Created by s.sivakarthi on 29/08/2022.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var temLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    
    let weatherDataModel = WeatherDataModel()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.stopUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        
        
        print("noooo")
        
        if location.horizontalAccuracy > 0{
            locationManager.stopUpdatingLocation()
            
            print("longitude is:::: \(location.coordinate.longitude) latitude is::: \(location.coordinate.latitude)" )
            let long = String(location.coordinate.longitude)
            let lat = String(location.coordinate.latitude)

            let params: [String: String] = ["lat": lat , "lon": long, "appid": weatherDataModel.apiurl]
            getWeatherData(url: weatherDataModel.apiurl, params: params)
            
        }
        
    }
    
    func getWeatherData(url: String, params: [String: String]){
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            
            if response.value != nil {
                let weatherJSON: JSON = JSON(response.value!)
                print("weatheris", weatherJSON)
                self.updateWeatherData(json: weatherJSON)
            }else{
                self.cityLabel.text = "Weather unavailable"
            }
        }
    }

    func updateWeatherData(json: JSON){
        if let tempResult = json["main"]["temp"].double{
            weatherDataModel.temp = Int(tempResult - 273.13)
            weatherDataModel.name = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
        }else{
            self.cityLabel.text = "Weather unavailable"
        }
        
    }
    
    func updateUI()
    {
        cityLabel.text = weatherDataModel.name
        temLabel.text = "\(weatherDataModel.temp)°"
    }

    @IBAction func changeCityButtonTapped(_ sender: Any) {
        
        print(Manager.cityName)

        
    }
}

