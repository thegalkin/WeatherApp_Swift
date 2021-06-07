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
