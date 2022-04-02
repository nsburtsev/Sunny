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
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    //метод получения информации по названию города
    func fetchCurrentWeather(forCity city: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        performRequest(withURLString: urlString)
    }
    
    //метод получения информации по широте и долготе
    func fetchCurrentWeather(forLatitude latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
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
