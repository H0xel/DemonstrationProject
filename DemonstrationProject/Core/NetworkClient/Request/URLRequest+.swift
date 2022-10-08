// Created by: Amakhin Ivan 

import Foundation

extension URLRequest {
    init?(request: Request) {
        guard let url = URL(string: "\(request.baseURL)\(request.path)") else { return nil }
        self.init(url: url)
    }
}
