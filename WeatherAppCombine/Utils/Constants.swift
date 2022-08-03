//
//  Constants.swift
//  WeatherAppCombine
//
//  Created by Lucas Romero Magaña on 3/8/22.
//

import Foundation


struct Constants {
    
    struct URLs {
        
        static func weather(city: String) -> String {
            return "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=1855faea061131d159e5e0ad0f159fc6&units=metric"
        }
    
    }
}
