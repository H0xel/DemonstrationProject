// Created by: Amakhin Ivan 

import Combine
import Foundation
import UIKit

final class FlowCoordinator {
    private weak var _navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        _navigationController = navigationController
    }

    func start() {
        _navigateToMainModule()
    }
}

extension FlowCoordinator {
    private func _navigateToMainModule() {
        let module = MainModule.create(dependency: .init(), payload: .init())

        module.output.sink { output in
            switch output {
            case let .openBeerDetails(beer):
                self._navigateToDetailsModule(beer: beer)
            }
        }.store(in: &module.ui.cancellable)
        let vc = module.ui
        _navigationController?.pushViewController(vc, animated: false)
    }

    private func _navigateToDetailsModule(beer: Beer) {
        let module = DetailsModule.create(
            dependency: .init(),
            payload: .init(beer: beer)
        )
        _navigationController?.pushViewController(module.ui, animated: true)
    }
}
