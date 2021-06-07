//
//  ContentView.swift
//  WeatherApp_2
//
//  Created by Никита Галкин on 07.06.2021.
//

import SwiftUI

struct ContentView: View {
	@StateObject var locationManager: LocationManager = LocationManager()
	var locationAllowed: Bool{
		locationManager.locationStatus == .authorizedAlways ||
			locationManager.locationStatus == .authorizedWhenInUse
	}
    var body: some View {
		if locationAllowed{
			TabView(){
				MainView().tabItem {
					VStack{
						Image(systemName: "thermometer.sun")
						Text("Текущая Погода")
					}
				}
				ForecastView().tabItem {
					VStack{
						Image(systemName: "list.dash")
						Text("Прогноз")
					}
				}
			}
		}else{
			Text("Без геолокации не работает")
		}
		
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
