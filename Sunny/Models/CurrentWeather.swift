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
        return "\(temperature.rounded())"
    }
    
    let feelsLikeTemperature: Double
    //изменяем формат на строку для возможности размещения температуры в ярлыке
    var feelsLikeTemperatureString: String {
        return "\(feelsLikeTemperature.rounded())"
    }
    
    let conditionCode: Int
    //инициализатор, который может вернуть nil, внутри которого будем передавать CurrentWeatherData
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLikeTemperature = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first!.id
    }
}
