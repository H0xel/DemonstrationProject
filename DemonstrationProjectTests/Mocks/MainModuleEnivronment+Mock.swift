// Created by: Amakhin Ivan 

@testable import DemonstrationProject

extension MainModuleSystem.Environment {
    static func mock(
        output: @escaping (MainOutput) -> Void = { _ in fatalError() },
        beerService: BeerService
    ) -> MainModuleSystem.Environment {
        .init(
            output: output,
            beerService: beerService
        )
    }
}
