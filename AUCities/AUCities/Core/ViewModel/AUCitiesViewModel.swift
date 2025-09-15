//
//  Untitled.swift
//  AUCities
//
//  Created by Sourabh on 15/09/25.
//

import Foundation

@MainActor
public final class AUCitiesViewModel: ObservableObject {
    @Published private(set) var arrCountry: [(state: String, cities: [CityModel], expanded: Bool)] = []
    @Published public private(set) var isLoading: Bool = false
    @Published public var reversed: Bool = false
    @Published public var lastError: AUCitiesError?

    private let service: AUCityService
    private let cache: CityCache

    public init(service: AUCityService, cache: CityCache = FileCache()) {
        self.service = service
        self.cache = cache
        loadCachedOrFetch()
    }

    private func loadCachedOrFetch() {
        if let cached: [CityModel] = cache.load([CityModel].self, forKey: AppConstants.cacheKey), !cached.isEmpty {
            apply(cities: cached)
        } else {
            refresh()
        }
    }

    private func apply(cities: [CityModel]) {
        /// first create the dictionary group  based on cities name (i.e admin name , which is states)
        /// where key is city name and value is states data
        let groupedDict = Dictionary(grouping: cities) { $0.admin_name }
        /// then sorts the cities keys
        let keys = groupedDict.keys.sorted()
        /// then create the array with tuple( which contains state, and array of cities data, and also isExpand)
        var arrCountry: [(state: String, arrCity: [CityModel], isExpand: Bool)] = keys.map { key in
            /// then sort the city and add it to Country array
            let list = groupedDict[key]!.sorted { $0.city < $1.city }
            return (key, list, true)
        }
        /// if reversed is tapped reversed the array
        if reversed {
            arrCountry = arrCountry.reversed()
            /// reversed the city array
            arrCountry = arrCountry.map { ($0.state, $0.arrCity.reversed(), $0.isExpand) }
        }
        /// return arrayofSates in AU Country
        self.arrCountry = arrCountry.map { (state: $0.state, cities: Array($0.arrCity), expanded: $0.isExpand) }
    }
}
public extension AUCitiesViewModel {
    func refresh() {
        isLoading = true
        Task {
            do {
                let cities = try await service.fetchCities()
                cache.save(cities, forKey: AppConstants.cacheKey)
                apply(cities: cities)
                isLoading = false
            } catch let error {
                lastError = error as? AUCitiesError
            }
        }
    }
    // Re-apply from cache to ensure deterministic behavior
     func toggleReverse() {
        reversed.toggle()
        if let cached: [CityModel] = cache.load([CityModel].self, forKey: AppConstants.cacheKey) {
            apply(cities: cached)
        }
    }
     func toggleSection(_ state: String) {
        if let idx = arrCountry.firstIndex(where: { $0.state == state }) {
            arrCountry[idx].expanded.toggle()
        }
    }
    
    func getCountryData() -> [(state: String, cities: [CityModel], expanded: Bool)] {
        return self.arrCountry
    }
    
    func getCities(section: (state: String, cities: [CityModel], expanded: Bool)) -> [CityModel] {
        return section.cities
    }
    
    func testRefresh() async throws {
        isLoading = true
        do {
            let cities = try await service.fetchCities()
            cache.save(cities, forKey: AppConstants.cacheKey)
            apply(cities: cities)
            isLoading = false
        } catch let error {
            lastError = error as? AUCitiesError
        }
    }
}
