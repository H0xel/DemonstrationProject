// Created by: Amakhin Ivan 

import Combine
import ComposableArchitecture
import Foundation

enum DetailsModuleSystem {
    typealias LocalStore = ComposableArchitecture.Store<State, Action>
    typealias LocalViewStore = ViewStore<State, Action>
    typealias LocalReducer = ComposableArchitecture.Reducer<State, Action, Environment>

    struct State: Equatable {
        let beer: Beer
    }

    enum Action: Equatable {
        case start
    }

    struct Environment {}

    static var reducer = Reducer<State, Action, Environment> { state, action, env in
        switch action {
        case .start:
            return .none
        }
    }
}
