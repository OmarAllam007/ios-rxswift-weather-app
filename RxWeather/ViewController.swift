//
//  ViewController.swift
//  RxWeather
//
//  Created by Omar Khaled on 19/07/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var cityNameTF: UITextField!
    
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityNameTF.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map { self.cityNameTF.text }
            .subscribe { city in
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    }else{
                        self.fetchWeather(by: city)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func displayWeather(_ weather:Weather?){
        if let weather = weather {
            print(weather.temp)
            let temp = (weather.temp - 32) * 0.5556
            self.temperatureLbl.text = "\(temp) ℃"
            self.humidityLbl.text = "\(weather.humidity) 💧"
        }else {
            self.temperatureLbl.text = "∅"
            self.humidityLbl.text = "∅"
        }
    }
    
    private func fetchWeather(by city:String)
    {
        guard let cityEncoded =
                city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL.weatherAPIURL(city: cityEncoded)
        else {
            return
        }
        
        let resource = Resource<WeatherResponse>(url: url)
        
        let search = URLRequest.load(resource: resource)
            .catchAndReturn(WeatherResponse.empty)
            .observe(on: MainScheduler.instance)
            
        
        search.map({ "\($0.main.temp) ℃" })
            .bind(to: self.temperatureLbl.rx.text)
            .disposed(by: disposeBag)
        
        search.map({ "\($0.main.humidity) 💧" })
            .bind(to: self.humidityLbl.rx.text)
            .disposed(by: disposeBag)
    }
    
    
}

