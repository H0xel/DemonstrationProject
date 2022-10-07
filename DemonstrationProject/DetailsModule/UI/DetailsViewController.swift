// Created by: Amakhin Ivan 

import UIKit
import Combine

final class DetailsViewController: UIViewController {
    private let _viewContainer = DetailsViewContainer()
    private let _viewStore: DetailsModuleSystem.LocalViewStore
    var cancellable = Set<AnyCancellable>()

    init(store: DetailsModuleSystem.LocalStore) {
        _viewStore = DetailsModuleSystem.LocalViewStore(store)
        super.init(nibName: nil, bundle: nil)
        _setupSubscriptions()
        _setupAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = _viewContainer
    }

    private func _setupAppearance() {
        view.backgroundColor = .white
    }

    private func _setupSubscriptions() {
        _viewStore.publisher
            .sink { [weak self] state in
                guard let self = self else { return }
                let viewState = DetailsConverter.convert(state)
                self.render(viewState)
            }
            .store(in: &cancellable)
    }
}

extension DetailsViewController {
    struct ViewState {
        let title: String
        let tagline: String
        let firstBrewed: String
        let welcomeDescription: String
        let imageURL: String
    }

    func render(_ viewState: ViewState) {
        title = viewState.title
        _viewContainer.render(.init(
            tagline: viewState.tagline,
            firstBrewed: viewState.firstBrewed,
            welcomeDescription: viewState.welcomeDescription,
            imageURL: viewState.imageURL)
        )
    }
}
