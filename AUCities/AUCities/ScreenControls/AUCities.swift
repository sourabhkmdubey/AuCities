//
//  AUCities.swift
//  AUCities
//
//  Created by Sourabh on 15/09/25.
//
import SwiftUI

public struct AUCities: View {
    let city: CityModel

    public var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(city.city)
                    .font(.body)
                Text("\(city.admin_name) • pop: \(city.population)")
                    .font(.caption)
                    .foregroundStyle(.primary)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(city.capital.isEmpty ? "" : city.capital.capitalized)
                    .font(.caption2)
                    .foregroundColor(.primary)
                Text("\(city.lat), \(city.lng)")
                    .font(.caption2)
                    .foregroundColor(.primary)
            }
        }
        .padding(.vertical, 6)
    }
}
