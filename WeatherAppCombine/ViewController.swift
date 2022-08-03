//
//  ViewController.swift
//  WeatherAppCombine
//
//  Created by Lucas Romero Magaña on 3/8/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    let webService: WebService = WebService()
    private var  cancellable: AnyCancellable? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPublisher()
        /*
        self.cancellable =  self.webService.fetchData(city: "Miami")
            .catch{_ in Just(Weather.placeholder)}
            .map { weather in
                if let temp = weather.temp {
                   return "\(temp)℃"
                } else {
                    return "Error gettig weather"
                }
            }.assign(to: \.text, on: self.temperatureLabel)
        */
    }


    private func setUpPublisher() {
        let publisher = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self.cityTextField)
        
        self.cancellable = publisher.compactMap{
            ($0.object as! UITextField).text?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        }.debounce(for: .milliseconds(100), scheduler: RunLoop.main)
            .flatMap { city in
                return self.webService.fetchData(city: city)
                    .catch{_ in Just(Weather.placeholder)}
                    .map{$0}

            }.sink {
                
                if let temperature = $0.temp {
                    self.temperatureLabel.text = "\(temperature)℃"
                }else {
                    self.temperatureLabel.text = ""
                }
              
            }
    }
    
}

