//
//  WebService.swift
//  WeatherAppCombine
//
//  Created by Lucas Romero Magaña on 3/8/22.
//

import Foundation
import Combine


struct WebService {
    
    func fetchData(city: String) -> AnyPublisher<Weather,Error>{
        
        guard let url = URL(string: Constants.URLs.weather(city: city)) else {
            fatalError("URL no válida")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .map{$0.main}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
