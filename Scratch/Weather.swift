//
//  Weather.swift
//  Memos
//
//  Created by Owen Henley on 9/10/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation

class Weather: Decodable {
    
    let weather: String
    
    init(weather: String) {
        self.weather = weather
    }
}

// MARK: - REST Structure

struct RootDictionary: Decodable {
    
    let data: [DataDictionaries]
}

struct DataDictionaries: Decodable {
    let weather: WeatherDictionary
}

struct WeatherDictionary: Decodable {
    let weatherDescription: String
    
    enum CodingKeys: String, CodingKey {
    case weatherDescription = "description"
    }
}
