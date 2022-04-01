//
//  CurrentWeather.swift
//  Sunny
//
//  Created by Нюргун on 31.03.2022.
//  Copyright © 2022 Ivan Akulov. All rights reserved.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    
    let temperature: Double
    //изменяем формат на строку для возможности размещения температуры в ярлыке
    var temperatureString: String {
        return String(format: "%.0f", temperature) //округление
    }
    
    let feelsLikeTemperature: Double
    //изменяем формат на строку для возможности размещения температуры в ярлыке
    var feelsLikeTemperatureString: String {
        return String(format: "%.0f", feelsLikeTemperature)
    }
    
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
    //инициализатор, который может вернуть nil, внутри которого будем передавать CurrentWeatherData
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLikeTemperature = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first!.id
    }
}
