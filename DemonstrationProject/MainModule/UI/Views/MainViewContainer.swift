// Created by: Amakhin Ivan 

import UIKit
import Combine

final class MainViewContainer: UIView {
    private let _loadedView = MainLoadedView()
    private let _loadingView = MainLoadingView()
    private let _errorView = MainErrorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        _setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func _setupSubviews() {
        _loadedView.translatesAutoresizingMaskIntoConstraints = false
        _loadingView.translatesAutoresizingMaskIntoConstraints = false
        _errorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(_loadedView)
        addSubview(_loadingView)
        addSubview(_errorView)

        NSLayoutConstraint.activate([
            _loadedView.topAnchor.constraint(equalTo: topAnchor),
            _loadedView.leadingAnchor.constraint(equalTo: leadingAnchor),
            _loadedView.trailingAnchor.constraint(equalTo: trailingAnchor),
            _loadedView.bottomAnchor.constraint(equalTo: bottomAnchor),

            _loadingView.topAnchor.constraint(equalTo: topAnchor),
            _loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            _loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            _loadingView.bottomAnchor.constraint(equalTo: bottomAnchor),

            _errorView.topAnchor.constraint(equalTo: topAnchor),
            _errorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            _errorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            _errorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension MainViewContainer {
    enum ViewState {
        case loading
        case loaded([Beer])
        case error(ErrorState)
    }

    func render(_ viewState: ViewState) {
        switch viewState {
        case .loading:
            _loadingView.isHidden = false
            _loadedView.isHidden = true
            _errorView.isHidden = true
        case let .loaded(beer):
            _loadingView.isHidden = true
            _loadedView.isHidden = false
            _loadedView.render(.init(beer: beer))
            _errorView.isHidden = true
        case let .error(state):
            _loadingView.isHidden = true
            _loadedView.isHidden = true
            _errorView.isHidden = false
            switch state {
            case .noInternet:
                _errorView.render(.noInternetError)
            case .expiredURL:
                _errorView.render(.expiredURL)
            }
        }
    }
}

extension MainViewContainer.ViewState {
    enum ErrorState {
        case noInternet
        case expiredURL
    }
}

extension MainViewContainer {
    enum Event {
        case reload
        case beerSelected(index: Int)
    }
    var events: AnyPublisher<Event, Never> {
        Publishers.MergeMany(
            _loadedView
                .events
                .map { events in
                    switch events {
                    case let .beerSelected(index):
                        return .beerSelected(index: index)
                    }
                }
                .eraseToAnyPublisher(),
            _errorView
                .events
                .map { _ in .reload }
                .eraseToAnyPublisher()
        )
        .eraseToAnyPublisher()
    }
}
