// Created by: Amakhin Ivan 

import UIKit
import Kingfisher

final class DetailsViewContainer: UIView {

    private let _image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    private let _label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let _descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        _setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func _setupAppearance() {
        backgroundColor = .white
    }

    private func _setupSubviews() {
        addSubview(_image)
        addSubview(_label)
        addSubview(_descriptionLabel)


        NSLayoutConstraint.activate([
            _image.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            _image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            _image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            _image.heightAnchor.constraint(equalToConstant: 300),

            _label.topAnchor.constraint(equalTo: _image.bottomAnchor, constant: 20),
            _label.centerXAnchor.constraint(equalTo: centerXAnchor),

            _descriptionLabel.topAnchor.constraint(equalTo: _label.bottomAnchor, constant: 20),
            _descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            _descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}

extension DetailsViewContainer {
    struct ViewState {
        let tagline: String
        let firstBrewed: String
        let welcomeDescription: String
        let imageURL: String
    }

    func render(_ viewState: ViewState) {
        let url = URL(string: viewState.imageURL)
        _image.kf.indicatorType = .activity
        _image.kf.setImage(with: url)

        _label.text = "1st brewed: \(viewState.firstBrewed)"
        _descriptionLabel.text = viewState.welcomeDescription
    }
}
