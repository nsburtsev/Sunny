//
//  CurrentWeatherData.swift
//  Sunny
//
//  Created by Нюргун on 31.03.2022.
//  Copyright © 2022 Ivan Akulov. All rights reserved.
//

import Foundation
//Модель для парсинга
struct CurrentWeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

struct Weather: Codable {
    let id: Int
}
