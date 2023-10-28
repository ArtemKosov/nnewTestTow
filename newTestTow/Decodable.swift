//
//  Decodable.swift
//  BDD
//
//  Created by Artem Kossov on 14.09.2023.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {

        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        let data: Data
            do {
                data = try Data(contentsOf: url)
            } catch {
                fatalError("Failed to load \(file) from bundle.: \(error)")
            }

        let decoder = JSONDecoder()
        let loaded: T
                do {
                    loaded = try decoder.decode(T.self, from: data)
                } catch {
                    fatalError("Failed to decode \(file) from bundle.: \(error)")
                }

        return loaded
    }
}
