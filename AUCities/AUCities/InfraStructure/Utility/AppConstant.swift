//
//  AppConstant.swift
//  AUCities
//
//  Created by Sourabh on 15/09/25.
//

import Foundation
enum AppConstants {
    static let appBackground = "Appbackground"
    static let appTitle = "AU Cities"
    static let upButtonImage = "chevron.up"
    static let downButtonImage = "chevron.down"
    static let leftToolBar = "arrow.clockwise"
    static let rightToolbar = "arrow.up.arrow.down"
    static let accesibilityIdentifier = "reverseButton"
    static let jsonFileName = "au_cities.json"
    static let cacheKey = "cities_cache_v1"
    static let cacheTTL: TimeInterval = 60 * 60 * 24 // 24 hours
}
