// Created by: Amakhin Ivan 

import Foundation

enum NetworkError: Error {
    case noInternet
    case expiredURL
}

extension NetworkError {
    init(_ error: Error?) {
        let error = error as? NSError
        self = [
            NSURLErrorNetworkConnectionLost,
            NSURLErrorResourceUnavailable,
            NSURLErrorInternationalRoamingOff,
            NSURLErrorNotConnectedToInternet
        ].contains(error?.code)
        ? .noInternet
        : .expiredURL
    }
}
