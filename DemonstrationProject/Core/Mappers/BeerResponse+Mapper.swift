// Created by: Amakhin Ivan 

import Foundation

extension Beer {
    init(_ response: BeerResponse) {
        id = response.id
        name = response.name
        tagline = response.tagline
        firstBrewed = response.firstBrewed
        welcomeDescription = response.welcomeDescription
        imageURL = response.imageURL
    }
}


extension Array where Element == Beer {
    init(beer: [BeerResponse]) {
        self = beer.map(Beer.init)
    }
}
