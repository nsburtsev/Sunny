//
//  NetworkWeatherManager.swift
//  Sunny
//
//  Created by Нюргун on 29.03.2022.
//  Copyright © 2022 Ivan Akulov. All rights reserved.
//

import Foundation
import CoreLocation
//Создаем менеджер сетевых запросов
class NetworkWeatherManager {
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        var urlString = ""
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        case .coordinate(let latitude, let longitude):
        urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
    }
    performRequest(withURLString: urlString)
}
    
    fileprivate func performRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data) {
                    self.onCompletion?(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    //Метод для парсинга
    fileprivate func parseJSON(withData data: Data) -> CurrentWeather? {
        //создаем декодер из JSON
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeater = CurrentWeather(currentWeatherData: currentWeatherData) else {
                return nil
            }
            return currentWeater
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
