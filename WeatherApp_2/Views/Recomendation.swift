//
//  Recomendation.swift
//  WeatherAppSwiftUI_Test
//
//  Created by Никита Галкин on 07.06.2021.
//

import SwiftUI

struct Recomendation: View {
	var weatherConditions: WeatherConditions
    var body: some View {
		switch weatherConditions {
			case .rain:
				Text("стоит взять зонт")
			case .fog:
				Text("включите дальние огни")
			case .sunny:
				Text("захватите солнечные очки")
			case .cloudy:
				Text("не депрессовать!")
			case .thunderStorm:
				Text("не стойте на холме с железными предметами")
			case .snow:
				Text("скоро новый год?")
			case .clear:
				Text("лучше погоды не придумаешь!")
			case .none:
				Text("?")
		}
    }
}

struct Recomendation_Previews: PreviewProvider {
    static var previews: some View {
		Recomendation(weatherConditions: .clear)
    }
}
