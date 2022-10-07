// Created by: Amakhin Ivan 

import Combine

public extension Publisher {
    func `catch`<T>(_ transform: @escaping (Failure) -> T) -> Publishers.Catch<Self, Just<T>> {
        self.catch { Just(transform($0)) }
    }
}
