// Created by: Amakhin Ivan 

import Combine
import ComposableArchitecture
import Foundation

enum MainModuleSystem {
    typealias LocalStore = ComposableArchitecture.Store<State, Action>
    typealias LocalViewStore = ViewStore<State, Action>
    typealias LocalReducer = ComposableArchitecture.Reducer<State, Action, Environment>

    struct State: Equatable {
        var mainState: MainState = .loading
    }

    enum MainState: Equatable {
        case loading
        case loaded([Beer])
        case error
    }

    enum Action: Equatable {
        case start
        case request
        case successReceived([Beer])
        case errorReceived
        case openBeerDetails(index: Int)
    }

    struct Environment {
        let output: (MainOutput) -> Void
        let beerService: BeerService
    }

    static var reducer = Reducer<State, Action, Environment> { state, action, env in
        switch action {
        case .start:
            return .init(value: .request)
        case .request:
            return env.beerService
                .getBeer()
                .map { .successReceived($0) }
                .catch { _ in .errorReceived }
                .eraseToEffect()
        case let .successReceived(beerData):
            state.mainState = .loaded(beerData)
            return .none
        case .errorReceived:
            state.mainState = .error
            return .none
        case let .openBeerDetails(index):
            if case let .loaded(beerData) = state.mainState {
                let beer = beerData[index]
                env.output(.openBeerDetails(beer))
            }
            return .none
        }
    }
}
