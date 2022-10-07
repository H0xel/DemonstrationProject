// Created by: Amakhin Ivan 

import Foundation

struct DetailsModule: FactoryModule {
    struct Dependency {}
    struct Payload {
        let beer: Beer
    }
    typealias Module = (ui: DetailsViewController, output: Void)

    static func create(dependency: Dependency, payload: Payload) -> Module {
        let store = DetailsModuleSystem.LocalStore(
            initialState: .init(beer: payload.beer),
            reducer: DetailsModuleSystem.reducer,
            environment: .init()
        )
        let vc = DetailsViewController(store: store)
        let module: Module = (vc, ())
        DetailsModuleSystem.LocalViewStore(store).send(.start)
        return module
    }
}
