//
//  AppDelegate.swift
//  DemonstrationProject
//
//  Created by Amakhin Ivan on 06.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let nc = UINavigationController()
        let module = FlowModule.create(dependency: .init(), payload: .init())
        module(nc)

        self.window?.rootViewController = nc
        self.window?.makeKeyAndVisible()
        return true
    }
}

