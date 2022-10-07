//
//  NetworkService.swift
//  DemonstrationProject
//
//  Created by Amakhin Ivan on 06.10.2022.
//
import Foundation
import Combine

protocol NetworkClient {
    func getRequest<T: Decodable>(url: URL) -> AnyPublisher<T, NetworkError>
}

final class NetworkClientImpl: NetworkClient {
    func getRequest<T>(url: URL) -> AnyPublisher<T, NetworkError> where T : Decodable {
        URLSession
            .shared
            .dataTaskPublisher(for: url)
            .tryMap { (data: Data, response: URLResponse) -> T in
                try JSONDecoder().decode(T.self, from: data)
            }
            .mapError { _ in .noInternet }
            .eraseToAnyPublisher()
    }
}
