// Created by: Amakhin Ivan

import Foundation
import Combine

extension NetworkClient {
    func makeBeerRequest<Response: Decodable>() -> AnyPublisher<Response, NetworkError> {
        let url = URL(string: "https://api.punkapi.com/v2/beers")!
        return getRequest(url: url)
            .eraseToAnyPublisher()
    }
}

extension NetworkClient {
    func fetchBeer() -> AnyPublisher<[BeerResponse], NetworkError> {
        makeBeerRequest()
    }
}
