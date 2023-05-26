//
//  ViewController.swift
//  Weather
//
//  Created by Роман Исламов on 26.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var getWeatherButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getWeatherButton.addTarget(self, action: #selector(didTapGetWeather), for: .touchUpInside)
    }
    
    @objc func didTapGetWeather() {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current_weather=true"
        let url = URL(string: urlString)!
        let request = URLRequest(url:url)
        let task = URLSession.shared.dataTask(with: request) { data,response, error in
            if let data, let weather = try? JSONDecoder().decode(WeatherData.self, from: data) {
                DispatchQueue.main.async {
                    self.weatherLabel.text = "\(weather.currentWeather.temperature) °"
                }
            } else {
                print("Not Parsed!")
            }
            
        }
        task.resume()
    }
    
    


}

