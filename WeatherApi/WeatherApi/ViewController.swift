//
//  ViewController.swift
//  WeatherApi
//
//  Created by Emircan saglam on 27.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather Api"
        
       
        
        
        
        
    }
    
    @IBAction func getApiAction(_ sender: Any) {
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=41.018550&lon=29.008845&appid=cb67b8fa71bdcd7ea11b354902ad6aff")
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                if data != nil {
                    
                    do {
                        
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
                        
                        DispatchQueue.main.async {
                            if let main = jsonResponse!["main"] as? [String:Any] {
                                if let temp = main["temp"]  as? Double {
                                    self.currentTemp.text = String(Int(temp-275.15))
                                }
                            }
                            if let wind = jsonResponse!["wind"] as? [String:Any] {
                                if let speed = wind["speed"] as? Double {
                                    self.windSpeed.text = String(Int(speed))
                                }
                            }
                            if let main = jsonResponse!["main"] as? [String:Any] {
                                if let feelsLike = main["feels_like"] as? Double {
                                    self.feelsLike.text = String(Int(feelsLike-275.15))
                                }
                            }
                            if let name = jsonResponse!["name"] {
                                self.nameLabel.text = String("\(name) Hava Durumu")
                            }
                               
                            
                        }
                    }catch {
                        
                    }
                    
                    
                    
                    
                }
            }
        }
        task.resume()
        
        
        
    }
    

}

