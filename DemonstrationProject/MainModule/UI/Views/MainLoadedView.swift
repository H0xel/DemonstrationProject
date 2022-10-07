// Created by: Amakhin Ivan 

import UIKit
import Combine

final class MainLoadedView: UIView {
    private let _tableView = UITableView()
    private var _beer: [Beer] = []
    private let _events = PassthroughSubject<Event, Never>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _setupTableview()
        _setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func _setupTableview() {
        backgroundColor = .white
        _tableView.delegate = self
        _tableView.dataSource = self
        _tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.reuseIdentifier)
    }

    private func _setupSubviews() {
        _tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(_tableView)
        NSLayoutConstraint.activate([
            _tableView.topAnchor.constraint(equalTo: topAnchor),
            _tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            _tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            _tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension MainLoadedView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        _events.send(.beerSelected(index: indexPath.row))
    }
}

extension MainLoadedView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        _beer.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MainCell.reuseIdentifier
        ) as! MainCell
        cell.render(.init(
            name: _beer[indexPath.row].name,
            tagline: _beer[indexPath.row].tagline
        ))
        return cell
    }
}

extension MainLoadedView {
    struct ViewState {
        let beer: [Beer]
    }

    func render(_ viewState: ViewState) {
        _beer = viewState.beer
        _tableView.reloadData()
    }
}

extension MainLoadedView {
    enum Event {
        case beerSelected(index: Int)
    }

    var events: AnyPublisher<Event, Never> {
        _events.eraseToAnyPublisher()
    }
}
