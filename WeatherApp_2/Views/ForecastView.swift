//
//  ForecastView.swift
//  WeatherApp_2
//
//  Created by Никита Галкин on 07.06.2021.
//

import SwiftUI

struct ForecastView: View {
	@StateObject var model: ForecastViewModel = ForecastViewModel()
    var body: some View {
		List{
			if model.weatherConditions.count != 0{
				ForEach(0..<model.weatherConditions.count){ i in
					HStack{
						Text(model.dates[i])
						WeatherEmodji(weatherConditions: model.weatherConditions[i])
						Text(model.temp[i])
					}
				}
			}else{
				Text("прогноз пуст")
			}
		}
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
    }
}
