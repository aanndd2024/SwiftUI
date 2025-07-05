//
//  NetworkService.swift
//  CryptoCoin
//
//  Created by Anand Yadav on 24/06/25.
//
import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse(statusCode: Int)
    case invalidData
    case decodingError(Error)
    case networkError(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse(let code): return "Invalid response (Status: \(code))"
        case .invalidData: return "Invalid data"
        case .decodingError(let error): return "Decoding error: \(error.localizedDescription)"
        case .networkError(let error): return "Network error: \(error.localizedDescription)"
        }
    }
}
struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.coingecko.com"
        components.path = "/api/v3/" + path
        components.queryItems = queryItems
        return components.url
    }
}

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ type: T.Type, endpoint: Endpoint) async -> Result<T, NetworkError>
}

class NetworkService: NetworkServiceProtocol {
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder
    
    init(urlSession: URLSession = .shared, jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
    
    func request<T>(_ type: T.Type, endpoint: Endpoint) async -> Result<T, NetworkError> where T : Decodable {
        guard let url = endpoint.url else {
            return .failure(.invalidURL)
        }
        
        do {
            let (data, response) = try await urlSession.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.invalidResponse(statusCode: -1))
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                return .failure(.invalidResponse(statusCode: httpResponse.statusCode))
            }
            
            do {
                let decodedData = try jsonDecoder.decode(T.self, from: data)
                return .success(decodedData)
            } catch let error as DecodingError {
                return .failure(.decodingError(error))
            } catch {
                return .failure(.invalidData)
            }
        } catch {
            return .failure(.networkError(error))
        }
    }
}
