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
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        
        if location.horizontalAccuracy > 0{
            locationManager.stopUpdatingLocation()
            
            print("noooo")
            
            
            print("long:::: \(location.coordinate.longitude), lat:::: \(location.coordinate.latitude)")
            let long = String(location.coordinate.longitude)
            let lat = String(location.coordinate.latitude)
            
            let params: [String: String] = ["lat": lat, "lon": long, "appid": weatherDataModel.apiID]
            
            let cityName = Manager.cityName
            
            if cityName == ""{
                
                getWeatherData(url: weatherDataModel.apiurl, params: params)

            }else{
                
                let cityParams: [String: String] = ["name": Manager.cityName , "appid": weatherDataModel.apiID]
                
                //getCityWeatherData(url: weatherDataModel.cityApiUrl, params: cityParams)
                
                getCityWeatherData(url: "https://api.openweathermap.org/data/2.5/weather?q=chennai&appid=0d7fc9d026024b3cd4a738aafc5483db")
                
                print(cityParams)
            }
            
           
        }
    }
    
    func getWeatherData(url: String, params: [String: String]){
        AF.request(url, method: .get, parameters: params).responseData { response in
            if response.value != nil {
                let waetherJSON: JSON = JSON(response.value!)
                //print("waetherJSON:", waetherJSON)
                self.updateWeatherData(json: waetherJSON)
            }else{
                self.cityLabel.text = "Weather unavailible"
            }
        }
    }
    
    func updateWeatherData(json: JSON){
        
        
        if let tempResult = json["main"]["temp"].double {

            weatherDataModel.temp = Int(tempResult - 273.13)
            weatherDataModel.name = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            updateUI()
        }else{
            self.cityLabel.text = "Weather unavailible"
        }
        
    }
    
    
    
    
    
    
    
    
    func updateUI(){
        cityLabel.text = weatherDataModel.name
        temLabel.text = "\(weatherDataModel.temp)º"
        
        weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
        
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)!

        
        
    }

        
    
    func getCityWeatherData(url: String){
        AF.request(url, method: .get).responseData { response in
            if response.value != nil {
                let waetherJSON: JSON = JSON(response.value!)
                print("waetherJSON:", waetherJSON)
                self.updateWeatherData(json: waetherJSON)
            }else{
                self.cityLabel.text = "Weather unavailible"
            }
        }
    }
    
        @IBAction func changeCityButtonTapped(_ sender: Any) {
    
            print(Manager.cityName)
    
    
        }

}
    
 
