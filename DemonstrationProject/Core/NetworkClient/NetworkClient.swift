//
//  NetworkService.swift
//  DemonstrationProject
//
//  Created by Amakhin Ivan on 06.10.2022.
//
import Foundation
import Combine

protocol NetworkClient {
    func getRequest<T: Decodable>(urlRequest: URLRequest) -> AnyPublisher<T, NetworkError>
}

final class NetworkClientImpl: NetworkClient {
    func getRequest<T>(urlRequest: URLRequest) -> AnyPublisher<T, NetworkError> where T : Decodable {
        URLSession
            .shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { (data: Data, response: URLResponse) -> T in
                try JSONDecoder().decode(T.self, from: data)
            }
            .mapError { NetworkError.init($0) }
            .eraseToAnyPublisher()
    }
}

#if DEBUG
final class NoInternetNetworkClient: NetworkClient {
    func getRequest<T>(urlRequest: URLRequest) -> AnyPublisher<T, NetworkError> where T : Decodable {
        Fail(outputType: T.self, failure: NetworkError.noInternet).eraseToAnyPublisher()
    }
}
#endif
