// Created by: Amakhin Ivan 

protocol FactoryModule {
    associatedtype Dependency
    associatedtype Payload
    associatedtype Module
    static func create(dependency: Dependency, payload: Payload) -> Module
}
