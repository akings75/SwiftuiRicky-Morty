//
//  WebService.swift
//  Ricky&MortinApi
//
//  Created by Ahmet Akın Özbulut on 14.04.2023.
//

import Foundation

enum NetworkError : Error {
    case invalidUrl
    case invalidSeverResponse
}

class Webservice {
    
    func download(_ resource: String) async throws ->[Character] {
        
        guard let url = URL(string: resource) else {
            throw NetworkError.invalidUrl
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else {
            
            throw NetworkError.invalidSeverResponse
        }
        
        return try JSONDecoder().decode([Character].self, from: data)
    }
}
