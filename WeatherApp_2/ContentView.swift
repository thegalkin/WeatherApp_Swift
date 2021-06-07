//
//  ContentView.swift
//  WeatherApp_2
//
//  Created by Никита Галкин on 07.06.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
