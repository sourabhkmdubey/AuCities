//
//  CityModel.swift
//  AUCities
//
//  Created by Sourabh on 15/09/25.
//

import Foundation

public struct CityModel: Codable, Identifiable, Hashable {
    public let id = UUID()
    public let city: String
    public let lat: String
    public let lng: String
    public let country: String
    public let iso2: String
    public let admin_name: String
    public let capital: String
    public let population: String
    public let population_proper: String

    enum CodingKeys: String, CodingKey {
        case city, lat, lng, country, iso2, admin_name, capital, population, population_proper
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.city = try container.decode(String.self, forKey: .city)
        self.lat = try container.decode(String.self, forKey: .lat)
        self.lng = try container.decode(String.self, forKey: .lng)
        self.country = try container.decode(String.self, forKey: .country)
        self.iso2 = try container.decode(String.self, forKey: .iso2)
        self.admin_name = try container.decode(String.self, forKey: .admin_name)
        self.capital = try container.decode(String.self, forKey: .capital)
        self.population = try container.decode(String.self, forKey: .population)
        self.population_proper = try container.decode(String.self, forKey: .population_proper)
    }
}
