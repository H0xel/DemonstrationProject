// Created by: Amakhin Ivan 

import Foundation

struct MethodAPI: Codable {
    let mashTemp: [MashTempAPI]
    let fermentation: FermentationAPI
    let twist: String?

    enum CodingKeys: String, CodingKey {
        case mashTemp = "mash_temp"
        case fermentation
        case twist
    }
}
