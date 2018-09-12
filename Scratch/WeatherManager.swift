//
//  WeatherManager.swift
//  Memos
//
//  Created by Owen Henley on 9/10/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation

class WeatherService {
    
    static let baseURL = URL(string: "https://api.weatherbit.io/v2.0/current")
    
    static func getWeather(completion: @escaping (String?) -> Void) {
        
        // Grab the Base URL
        let url = baseURL!
        
        // Set up Components
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        // Set Query Papameters
        let city = URLQueryItem(name: "city", value: "Salt Lake City, UT")
        let key = URLQueryItem(name: "key", value: "230e34abb24c4b46a8a41acd80d373ae")
        
        // pull the components together
        components?.queryItems = [city, key]
        
        // Append components to baseURL
        guard let fullURL = components?.url else { return }
        print("\(fullURL.absoluteString)")
        
        // URLRequest
        var request = URLRequest(url: fullURL)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        
        // MARK: - URLSession
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                print("Error with URLSession: \(error.localizedDescription) ❌")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Error getting unwrapped data ❌")
                completion(nil)
                return
            }
            
            print(data)
            
            // MARK: - Decode JSON Data
            
            do {
                let jsonDecoder = JSONDecoder()
                let rootDictionary = try jsonDecoder.decode(RootDictionary.self, from: data)
                guard let weather = rootDictionary.data.first?.weather.weatherDescription else {
                    completion(nil)
                    return }
                completion(weather)
            } catch {
                print("Error Decoding JSON: \(error.localizedDescription)")
                completion(nil)
            }
        
        }.resume()
    }
}
