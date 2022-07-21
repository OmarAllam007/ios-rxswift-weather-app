//
//  Weather.swift
//  RxWeather
//
//  Created by Omar Khaled on 19/07/2022.
//

import Foundation
//https://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=367540ac1721d67dd909fd56e8bbd2ba
struct WeatherResponse : Decodable {
    let main: Weather
    
    static var empty:WeatherResponse {
        return WeatherResponse(main: Weather(temp: 0.0, humidity: 0.0))
    }
}

struct Weather:Decodable {
    let temp:Double
    let humidity:Double 
    
}
