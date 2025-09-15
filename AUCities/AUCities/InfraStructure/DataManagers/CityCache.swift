//
//  FileCache.swift
//  AUCities
//
//  Created by Sourabh on 15/09/25.
//

import Foundation
public protocol CityCache {
    func save<T: Codable>(_ value: T, forKey: String)
    func load<T: Codable>(_ type: T.Type, forKey: String) -> T?
    func clear(forKey: String)
}

/// For Creating The Cache for AUCities
public final class FileCache: CityCache {
    private let fm = FileManager.default
    private let folder: URL
    /****
     initilisation of Cache
     takes the folderName or by default create with default value
     ***/
    public init(folderName: String = "AUCitiesCache") {
        let caches = fm.urls(for: .cachesDirectory, in: .userDomainMask).first ?? URL(fileURLWithPath: NSTemporaryDirectory())
        folder = caches.appendingPathComponent(folderName)
        try? fm.createDirectory(at: folder, withIntermediateDirectories: true, attributes: nil)
    }
    /****
     save the data to particular file
     takes codable value and save to particular path based on key
     ***/
    public func save<T: Codable>(_ value: T, forKey: String) {
        let url = folder.appendingPathComponent(forKey)
        do {
            let data = try JSONEncoder().encode(value)
            try data.write(to: url)
        } catch {
            print("Cache save error:", error)
        }
    }
    /****
     extract the data from particular file
     converts the data into Json format and load the converted data
     take the codable data from particular key
     ***/
    public func load<T: Codable>(_ type: T.Type, forKey: String) -> T? {
        let url = folder.appendingPathComponent(forKey)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try? JSONDecoder().decode(type, from: data)
    }

    /****
     clear the data from particluar file which is present in 'AUCitiesCache' folder
     take key to remove it
     ***/
    public func clear(forKey: String) {
        let url = folder.appendingPathComponent(forKey)
        try? fm.removeItem(at: url)
    }
}
