//
//  AppDelegate.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 27.03.2023.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        AppearanceManager.start()
        return true
    }
}
