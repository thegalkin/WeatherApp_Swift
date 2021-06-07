//
//  ForecastViewModel.swift
//  WeatherApp_2
//
//  Created by Никита Галкин on 07.06.2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class ForecastViewModel: ObservableObject{
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
	@Published var weatherConditions: [WeatherConditions] = []
	
	func setWeatherConditions(){
		guard let conditionsTemp = currentWeather else {
			return
		}
		
		let dayList = conditionsTemp["list"].arrayValue
		for d in dayList{
			weatherConditions.append(day(d))
		}
		
		func day(_ oneDay: JSON) -> WeatherConditions{
			
			let detailedConditions = oneDay["weather"][0]["id"].intValue
			
			switch detailedConditions {
				case 800:
					return .clear
				case 200...232:
					return .thunderStorm
				case 300...321:
					return .rain
				case 500...531:
					return .rain
				case 600...622:
					return .snow
				case 700...781:
					return .fog
				case 801...804:
					return .cloudy
				default:
					return .none
			}
		}
		
	}
	@Published var city: String = ""
	@Published var temp: [String] = []
	@Published var dates: [String] = []
	
	func setDates(){
		let dayList = currentWeather!["list"].arrayValue
		for d in dayList{
			dates.append(d["dt_txt"].stringValue)
		}
	}
	func setCity(){
		if currentWeather != nil{
			city = currentWeather!["name"].string ?? "Где-то"
		}else{
			city = "Где-то"
		}
		
	}
	
	func setTemp(){
		if currentWeather != nil{
			let dayList = currentWeather!["list"].arrayValue
			for d in dayList{
				let t = d["main"]["temp"].stringValue + "ºC"
				temp.append(t)
			}
		}
	}
	
	func getCurrentWeatherByLocation(){
		print(lat + " " + lon)
		AF.request(URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&id=524901&lang=ru&appid=\(weatherApiKey)&units=metric")!)
			.response{ response in
				switch response.result{
					case .success:
						self.currentWeather = JSON(response.data!)
						self.setCity()
						self.setTemp()
						self.setDates()
						self.setWeatherConditions()
						print("successful request, data:")
						print(JSON(response.data ?? ""))
					case .failure(let error):
						print(error.localizedDescription)
				}
			}
	}
}
