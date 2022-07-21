//
//  URL + Extensions.swift
//  RxWeather
//
//  Created by Omar Khaled on 21/07/2022.
//

import Foundation

extension URL {
    
    static func weatherAPIURL(city:String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=367540ac1721d67dd909fd56e8bbd2ba")
    }
}
