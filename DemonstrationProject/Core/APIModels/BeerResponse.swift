// Created by: Amakhin Ivan

import Foundation

struct BeerResponse: Codable {
    let id: Int
    let name: String
    let tagline: String
    let firstBrewed: String
    let welcomeDescription: String
    let imageURL: String
    let abv: Double
    let ibu: Double?
    let targetFg: Int
    let targetOg: Double
    let ebc: Int?
    let srm, ph: Double?
    let attenuationLevel: Double
    let volume: BoilVolumeAPI
    let boilVolume: BoilVolumeAPI
    let method: MethodAPI
    let ingredients: IngredientsAPI
    let foodPairing: [String]
    let brewersTips: String
    let contributedBy: ContributedByAPI

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case tagline
        case firstBrewed = "first_brewed"
        case welcomeDescription = "description"
        case imageURL = "image_url"
        case abv
        case ibu
        case targetFg = "target_fg"
        case targetOg = "target_og"
        case ebc
        case srm
        case ph
        case attenuationLevel = "attenuation_level"
        case volume
        case boilVolume = "boil_volume"
        case method
        case ingredients
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
    }
}
