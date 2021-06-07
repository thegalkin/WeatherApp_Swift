//
//  MainView.swift
//  WeatherAppSwiftUI_Test
//
//  Created by Никита Галкин on 07.06.2021.
//

import SwiftUI
import SwiftyJSON

struct MainView: View {
	@StateObject var model = WeatherViewModel()
	
	@State var cityEntry: String = ""
	var body: some View {
		NavigationView(){
			if model.currentWeather == JSON(){
				ProgressView().progressViewStyle(DefaultProgressViewStyle())
			}else{
				VStack{
					Spacer()
					HStack{
						WeatherEmodji(weatherConditions: model.weatherConditions).font(.system(.largeTitle))
						Text(model.temp).font(.system(.largeTitle))
					}
					.navigationTitle(model.city)
					Spacer()
					Recomendation(weatherConditions: model.weatherConditions)
					Spacer()
					Form{
					HStack{
//						Spacer().frame(minWidth: 10)
						TextField("City", text: $cityEntry)
						Spacer()
						Button(action: {
							UserDefaults.standard.setValue(cityEntry, forKey: "city")
							if cityEntry == ""{
								model.workingMode = .location
							}else{
								model.workingMode = .city
							}
							model.getCurrentWeatherByLocation()
							
						}){
							Text("Сохранить")
								.font(.footnote)
								.lineLimit(1)
								.padding()
								.foregroundColor(.white)
								.background(Color.blue)
								.cornerRadius(10)
								
						}
//						Spacer().frame(minWidth: 10)
					}
					Text("Пустое поле для активации геолокации").font(.footnote).foregroundColor(.gray)
					}.frame(maxHeight: 200)
				}
			}
		}
	}
}

struct MainView_Previews: PreviewProvider {
	@StateObject static var model: WeatherViewModel = WeatherViewModel()
	static var previews: some View {
		MainView().environmentObject(model)
	}
}
