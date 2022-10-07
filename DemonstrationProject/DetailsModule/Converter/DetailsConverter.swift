// Created by: Amakhin Ivan 

import Foundation

enum DetailsConverter {
    static func convert(_ state: DetailsModuleSystem.State) -> DetailsViewController.ViewState {
        let beer = state.beer
        return .init(
            title: beer.name,
            tagline: beer.tagline,
            firstBrewed: beer.firstBrewed,
            welcomeDescription: beer.welcomeDescription,
            imageURL: beer.imageURL
        )
    }
}
