// Created by: Amakhin Ivan 

import Foundation

enum MainConverter {
    static func convert(_ state: MainModuleSystem.State) -> MainViewController.ViewState {
        switch state.mainState {
        case .loading:
            return .loading
        case let .loaded(beer):
            return .loaded(beer)
        case let .error(errorState):
            switch errorState {
            case .noInternet:
                return .error(.noInternet)
            case .expiredURL:
                return .error(.expiredURL)
            }
        }
    }
}
