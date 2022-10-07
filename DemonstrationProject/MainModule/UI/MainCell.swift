// Created by: Amakhin Ivan 

import UIKit

final class MainCell: UITableViewCell {
    private let _label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let _detailsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    static let reuseIdentifier = description()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        _setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func _setupSubviews() {
        addSubview(_label)
        addSubview(_detailsLabel)

        NSLayoutConstraint.activate([
            _label.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            _label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            _label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),

            _detailsLabel.topAnchor.constraint(equalTo: _label.bottomAnchor, constant: 6),
            _detailsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            _detailsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            _detailsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6)
        ])
    }
}

extension MainCell {
    struct ViewState {
        let name: String
        let tagline: String
    }

    func render(_ viewState: ViewState) {
        _label.text = viewState.name
        _detailsLabel.text = viewState.tagline
    }
}
