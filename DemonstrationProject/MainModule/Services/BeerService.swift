// Created by: Amakhin Ivan 

import Combine
import Foundation

protocol BeerService {
    func getBeer() -> AnyPublisher<[Beer], NetworkError>
}

final class BeerServiceImpl: BeerService {
    private let _networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        _networkClient = networkClient
    }

    func getBeer() -> AnyPublisher<[Beer], NetworkError> {
        _networkClient
            .fetchBeer()
            .map { .init(beer: $0) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

