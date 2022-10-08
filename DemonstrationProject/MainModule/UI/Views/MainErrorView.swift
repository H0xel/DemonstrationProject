// Created by: Amakhin Ivan 

import UIKit
import Combine

final class MainErrorView: UIView {
    private let _events = PassthroughSubject<Event, Never>()

    private let _button: UIButton = {
        let button = UIButton()
        button.setTitle("Reload", for: .normal)
        button.setTitleColor(UIColor.link, for: .normal)
        return button
    }()

    private let _label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        _setupSubviews()
        _setupButton()
        _setupAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func _setupAppearance() {
        backgroundColor = .white
    }

    private func _setupButton() {
        _button.addTarget(self, action: #selector(reload), for: .touchUpInside)
    }

    private func _setupSubviews() {
        _label.translatesAutoresizingMaskIntoConstraints = false
        _button.translatesAutoresizingMaskIntoConstraints = false

        addSubview(_label)
        addSubview(_button)

        NSLayoutConstraint.activate([
            _label.centerXAnchor.constraint(equalTo: centerXAnchor),
            _label.centerYAnchor.constraint(equalTo: centerYAnchor),

            _button.centerXAnchor.constraint(equalTo: centerXAnchor),
            _button.topAnchor.constraint(equalTo: _label.bottomAnchor, constant: 10)
        ])
    }

    @objc private func reload() {
        _events.send(.reload)
    }
}

extension MainErrorView {
    enum ViewState {
        case noInternetError
        case expiredURL
    }

    func render(_ viewState: ViewState) {
        switch viewState {
        case .noInternetError:
            _label.text = "Oups, something goes wrong!"
            _button.isHidden = false
        case .expiredURL:
            _label.text = "URL expired :("
            _button.isHidden = true
        }
    }
}

extension MainErrorView {
    enum Event {
        case reload
    }

    var events: AnyPublisher<Event, Never> {
        _events.eraseToAnyPublisher()
    }
}
