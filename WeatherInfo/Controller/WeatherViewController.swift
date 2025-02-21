//
//  ViewController.swift
//  WeatherInfo
//
//  Created by Aryan Vasudeva on 15/07/2024.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    
    

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var condition: UILabel!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        weatherManager.delegate = self
        searchTextField.delegate = self
        // notify the view comtroller about what is the user is doing
        // self refers to the current view comtroller
    }
    
    // this is for when the search button is pressed
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)// the keybpard disappears
//        print("\(searchTextField.text ?? "No name entered")")// the search text field is an optional string
        //i am adding another comment
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)// the keybpard disappears
//        print("\(searchTextField.text ?? "No name entered")")
        return true
    }
    
    //already done by default but this helops in clearing the search space
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    //to check whether the user has entered something in the text field or not
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }else{
            textField.placeholder = "Enter the city Name"// the light coloured text
            return false
            
        }
    }
    
    // this function runs when the user has stopped editing in the text field
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let cityNameEntered = searchTextField.text{
            weatherManager.fetchWeather(cityName: cityNameEntered)
            print(cityNameEntered)
            searchTextField.text = ""//clears the text field when the editing has ended
        }
    
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        
        
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.name
        }
        
    }
    
    
    func didFailWithError(error: any Error) {
        print(error)
    }


}

