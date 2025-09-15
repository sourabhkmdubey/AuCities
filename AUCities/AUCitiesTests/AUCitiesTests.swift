//
//  AUCitiesTests.swift
//  AUCitiesTests
//
//  Created by Sourabh on 15/09/25.
//

import XCTest
@testable import AUCities
final class AUCitiesTests: XCTestCase {
    var auCitiesViewModel: AUCitiesViewModel?
    
    override func setUp() async throws {
        try await super.setUp()
        self.auCitiesViewModel =  await AUCitiesViewModel(service: AUCityServiceImpl())
    }
    
    override func tearDown() async throws {
        try await super.tearDown()
        self.auCitiesViewModel = nil
    }
    
    @MainActor
    func test_ArrayOfCountry() {
        XCTAssertNotNil(auCitiesViewModel)
        XCTAssertEqual(auCitiesViewModel?.arrCountry.count, 8)
        XCTAssertNotNil(auCitiesViewModel?.arrCountry)
        XCTAssertTrue(((auCitiesViewModel?.arrCountry.contains { $0.state == "Australian Capital Territory" }) != nil))
        XCTAssertTrue(((auCitiesViewModel?.arrCountry.contains { $0.cities[0].city == "Canberra" }) != nil))
    }
    
    @MainActor
    func test_ArrayOfCountry_WithRefresh() async throws {
        XCTAssertNotNil(auCitiesViewModel)
        try await auCitiesViewModel?.testRefresh()
        XCTAssertEqual(auCitiesViewModel?.arrCountry.count, 8)
        XCTAssertNotNil(auCitiesViewModel?.arrCountry)
        XCTAssertTrue(((auCitiesViewModel?.arrCountry.contains { $0.state == "Australian Capital Territory" }) != nil))
        XCTAssertTrue(((auCitiesViewModel?.arrCountry.contains { $0.cities[0].city == "Canberra" }) != nil))
    }
    
    @MainActor
    func test_ArrayOfCountry_OnReverseOrder() {
        XCTAssertNotNil(auCitiesViewModel)
        auCitiesViewModel?.toggleReverse()
        XCTAssertEqual(auCitiesViewModel?.arrCountry.count, 8)
        XCTAssertNotNil(auCitiesViewModel?.arrCountry)
        XCTAssertTrue(((auCitiesViewModel?.arrCountry.contains { $0.state == "Western Australia"}) != nil))
        XCTAssertTrue(((auCitiesViewModel?.arrCountry.contains { $0.cities[0].city == "Yanchep"}) != nil))
    }
}
