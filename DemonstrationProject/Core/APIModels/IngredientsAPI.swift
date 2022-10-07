// Created by: Amakhin Ivan 

import Foundation

struct IngredientsAPI: Codable {
    let malt: [MaltAPI]
    let hops: [HopAPI]
    let yeast: String
}
