// Created by: Amakhin Ivan 

import Foundation

enum MainConverter {
    static func convert(_ state: MainModuleSystem.State) -> MainViewController.ViewState {
        switch state.mainState {
        case .loading:
            return .loading
        case let .loaded(beer):
            return .loaded(beer)
        case .error:
            return .error
        }
    }
}
