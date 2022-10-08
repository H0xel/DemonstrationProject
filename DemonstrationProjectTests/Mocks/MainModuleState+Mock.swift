// Created by: Amakhin Ivan 

@testable import DemonstrationProject

extension MainModuleSystem.State {
    static func mock(_ state: MainModuleSystem.MainState) -> MainModuleSystem.State {
        .init(mainState: state)
    }
}
