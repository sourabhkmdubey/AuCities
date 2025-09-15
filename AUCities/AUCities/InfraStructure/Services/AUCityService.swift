//
//  AUCityServiceImpl.swift
//  AUCities
//
//  Created by Sourabh on 15/09/25.
//

import Foundation
import Combine

public enum AUCitiesError: Error {
   case fileNotFound
   case dataNotFound
   case dataNotConverted
   case somethingWentWrong
}
public protocol AUCityService {
    func fetchCities() async throws  -> [CityModel]
}

public final class AUCityServiceImpl: AUCityService {

    public init() {}
    
    // Simulate network fetch by loading bundled JSON (au_cities.json) asynchronously.
    public func fetchCities() async throws  -> [CityModel] {
        guard let url = Bundle.main.url(forResource: "au_cities", withExtension: "json") else {
            throw AUCitiesError.fileNotFound
        }
        do {
            guard let data = try? Data(contentsOf: url) else { throw AUCitiesError.dataNotFound }
            guard let cities = try? JSONDecoder().decode([CityModel].self, from: data) else { throw AUCitiesError.dataNotConverted }
            return cities
        } catch {
            throw AUCitiesError.somethingWentWrong
        }
    }
}
