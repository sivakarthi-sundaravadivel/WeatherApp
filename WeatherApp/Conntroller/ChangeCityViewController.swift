//
//  ChangeCityViewController.swift
//  WeatherApp
//
//  Created by s.sivakarthi on 29/08/2022.
//

import UIKit

class ChangeCityViewController: UIViewController {

    @IBOutlet var cityNameInput: DesignableTextField!
    @IBOutlet var cityNamePass: DesignButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func cityNameButtonTapped(_ sender: Any) {
        
        let cityNameInput = cityNameInput.text
        Manager.cityName = cityNameInput!
        
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
