// Created by: Amakhin Ivan 

import Foundation
import Combine

struct MainModule: FactoryModule {
    struct Dependency {}
    struct Payload {}
    typealias Module = (ui: MainViewController, output: AnyPublisher<MainOutput, Never>)

    static func create(dependency: Dependency, payload: Payload) -> Module {
        let output = PassthroughSubject<MainOutput, Never>()
        let store = MainModuleSystem.LocalStore(
            initialState: .init(),
            reducer: MainModuleSystem.reducer,
            environment: .init(
                output: output.send,
                beerService: BeerServiceImpl(
                    networkClient: NetworkClientImpl()
                )
            )
        )
        let vc = MainViewController(store: store)
        let module: Module = (vc, output.eraseToAnyPublisher())
        MainModuleSystem.LocalViewStore(store).send(.start)
        return module
    }
}
