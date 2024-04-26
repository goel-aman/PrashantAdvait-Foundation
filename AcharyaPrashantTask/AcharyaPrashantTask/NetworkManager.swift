//
//  NetworkManager.swift
//  AcharyaPrashantTask
//
//  Created by aman on 23/04/24.
//

import Foundation

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}

class NetworkManager {
    func getImagesData(from url: String) async throws -> [Query] {
        guard let url = URL(string: url) else {
            throw DataError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw DataError.invalidResponse
        }
        
        return try JSONDecoder().decode([Query].self, from: data)
    }
}
