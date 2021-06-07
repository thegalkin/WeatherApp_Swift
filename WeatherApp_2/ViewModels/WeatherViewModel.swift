//
//  WeatherViewModel.swift
//  WeatherAppSwiftUI_Test
//
//  Created by Никита Галкин on 07.06.2021.
//

import Foundation
import SwiftUI
import SwiftyJSON
import Alamofire

enum WeatherConditions {
	case rain
	case sunny
	case cloudy
	case thunderStorm
	case snow
	case fog
	case clear
	case none
}

class WeatherViewModel: ObservableObject{
	//разместил ключ здесь, потому что так он хотя бы будет закодирован в бинарник,
	//но лучшее решение, конечно, хранить на сервере, который выступает в виде прокси
	private var weatherApiKey = "60e5f4e300d35c53f771a04539b8a238"
	
	init(){
		Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true){ timer in
			if self.lat != "0.0" && self.lon != "0.0"{
				self.getCurrentWeatherByLocation()
				timer.invalidate()
			}
		}
		self.currentWeather = JSON(UserDefaults.standard.string(forKey: "currentWeather") ?? "")
		self.setCity()
		self.setTemp()
		self.setWeatherConditions()
		
	}
	
	
	private let locationManager = LocationManager()
	
	private var lat: String{
		
		return String(locationManager.lastLocation?.coordinate.latitude ?? 0)
		
	}
	private var lon: String {
		
		return String(locationManager.lastLocation?.coordinate.longitude ?? 0)
	}
	
	
	
	@Published var currentWeather: JSON? = JSON()
	
	
	//столкнулся с утечкой памяти и тем, что view не запускалось. Причина оказалась в том, что SwiftUi не может использовать computed property внутри вью, в ситуации, когда эта property находится не внутри struct нашего view
	@Published var weatherConditions: WeatherConditions = .none
	func setWeatherConditions(){
		guard let conditionsTemp = currentWeather else {
			weatherConditions = .none
			return
		}
		let detailedConditions = conditionsTemp["weather"][0]["id"].intValue
		
		switch detailedConditions {
			case 800:
				weatherConditions = .clear
			case 200...232:
				weatherConditions = .thunderStorm
			case 300...321:
				weatherConditions = .rain
			case 500...531:
				weatherConditions = .rain
			case 600...622:
				weatherConditions = .snow
			case 700...781:
				weatherConditions = .fog
			case 801...804:
				weatherConditions = .cloudy
			default:
				weatherConditions = .none
		}
		
	}
	@Published var city: String = ""
	@Published var temp: String = ""
	
	
	func setCity(){
		if currentWeather != nil{
			city = currentWeather!["name"].string ?? "Somewhere"
		}else{
			city = "Somewhere"
		}
		
	}
	
	func setTemp(){
		
		if currentWeather != nil{
			temp = currentWeather!["main"]["temp"].stringValue + "ºC"
		}else{
			temp = "?" + "ºC"
		}
		
	}
	
	func getCurrentWeatherByLocation(){
		print(lat + " " + lon)
		AF.request(URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(weatherApiKey)&units=metric")!)
			.response{ response in
				switch response.result{
					case .success:
						self.currentWeather = JSON(response.data!)
						self.setCity()
						self.setTemp()
						self.setWeatherConditions()
						UserDefaults.standard.setValue(self.currentWeather!.rawString()!, forKey: "currentWeather")
						print("successful request, data:")
						print(JSON(response.data ?? ""))
					case .failure(let error):
						print(error.localizedDescription)
						self.currentWeather = JSON(UserDefaults.standard.string(forKey: "currentWeather") ?? "")
						
				}
			}
	}
	
	
	
}
