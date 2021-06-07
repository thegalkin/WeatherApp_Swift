//
//  WeatherEmodji.swift
//  WeatherAppSwiftUI_Test
//
//  Created by Никита Галкин on 07.06.2021.
//

import SwiftUI

struct WeatherEmodji: View {
	var weatherConditions: WeatherConditions
	
	
    var body: some View {
		
		switch weatherConditions {
			case .rain:
				Text("🌧")
			case .fog:
				Text("🌫")
			case .sunny:
				Text("🌞")
			case .cloudy:
				Text("☁️")
			case .thunderStorm:
				Text("🌩")
			case .snow:
				Text("❄️")
			case .clear:
				Text("🔵")
			case .none:
				Text("?")
		}
    }
}

struct WeatherEmodji_Previews: PreviewProvider {
    static var previews: some View {
		WeatherEmodji(weatherConditions: .rain)
    }
}
