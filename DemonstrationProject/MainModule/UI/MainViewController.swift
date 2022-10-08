// Created by: Amakhin Ivan 

import UIKit
import Combine
import ComposableArchitecture

final class MainViewController: UIViewController {
    var cancellable = Set<AnyCancellable>()
    private let _viewStore: MainModuleSystem.LocalViewStore
    private let _viewContainer = MainViewContainer()

    init(store: MainModuleSystem.LocalStore) {
        _viewStore = MainModuleSystem.LocalViewStore(store)
        super.init(nibName: nil, bundle: nil)
        _setupSubscriptions()
        _setupAppearance()
    }

    override func loadView() {
        view = _viewContainer
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func _setupAppearance() {
        title = "Beer list"
    }

    private func _setupSubscriptions() {
        _viewStore.publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in 
                guard let self = self else { return }
                let viewState = MainConverter.convert(state)
                self.render(viewState)
            }.store(in: &cancellable)

        _viewContainer.events
            .sink { [weak self] events in
                guard let self = self else { return }
                switch events {
                case .reload:
                    self._viewStore.send(.request)
                case let .beerSelected(index):
                    self._viewStore.send(.openBeerDetails(index: index))
                }
            }.store(in: &cancellable)
    }
}

extension MainViewController {
    enum ViewState {
        case loading
        case loaded([Beer])
        case error(ErrorState)
    }
    
    func render(_ viewState: ViewState) {
        switch viewState {
        case .loading:
            _viewContainer.render(.loading)
        case let .loaded(beer):
            _viewContainer.render(.loaded(beer))
        case let .error(errorState):
            switch errorState {
            case .noInternet:
                _viewContainer.render(.error(.noInternet))
            case .expiredURL:
                _viewContainer.render(.error(.expiredURL))
            }
        }
    }
}

extension MainViewController.ViewState {
    enum ErrorState {
        case noInternet
        case expiredURL
    }
}
