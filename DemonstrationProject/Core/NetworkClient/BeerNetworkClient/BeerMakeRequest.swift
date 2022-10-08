// Created by: Amakhin Ivan

import Foundation
import Combine

extension NetworkClient {
    func makeBeerRequest<Response: Decodable>() -> AnyPublisher<Response, NetworkError> {
        guard let urlRequest: URLRequest = .init(request: BeerRequest()) else {
            return Fail(outputType: Response.self, failure: NetworkError.expiredURL)
                .eraseToAnyPublisher()
        }
        return getRequest(urlRequest: urlRequest)
            .eraseToAnyPublisher()
    }
}

extension NetworkClient {
    func fetchBeer() -> AnyPublisher<[BeerResponse], NetworkError> {
        makeBeerRequest()
    }
}
