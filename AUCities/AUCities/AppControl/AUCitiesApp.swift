//
//  AUCitiesApp.swift
//  AUCities
//
//  Created by Sourabh on 15/09/25.
//

import SwiftUI

@main
struct AUCitiesApp: App {
    var body: some Scene {
        WindowGroup {
            AUStates(viewModel: AUCitiesViewModel(service: AUCityServiceImpl()))
                .background(Color("Appbackground"))
        }
    }
}
