// Created by: Amakhin Ivan 

import Foundation
import UIKit

struct FlowModule: FactoryModule {

    struct Dependency {}

    struct Payload {}

    typealias Module = (UINavigationController) -> Void

    static func create(
        dependency: Dependency,
        payload: Payload
    ) -> Module {
        let coordinator: (UINavigationController) -> FlowCoordinator = {
            FlowCoordinator(navigationController: $0)
        }

        let ui: (UINavigationController) -> Void = {
            coordinator($0).start()
        }
        return ui
    }
}
