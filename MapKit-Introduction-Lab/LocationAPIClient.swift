//
//  LocationAPIClient.swift
//  MapKit-Introduction-Lab
//
//  Created by Matthew Ramos on 2/25/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation
import NetworkHelper

struct LocationAPIClient {
    static func fetchLocations (completion: @escaping (Result<[Location], AppError>) -> ()) {
        let endpointURLString = "https://data.cityofnewyork.us/resource/uq7m-95z8.json"
        guard let url = URL(string: endpointURLString) else {
            completion(.failure(.badURL(endpointURLString)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(appError))
            case .success(let data):
                do {
                    let locations = try JSONDecoder().decode([Location].self, from: data)
                    completion(.success(locations))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
            
        }
    }
    
}
