//
//  AppearanceManager.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 18.04.2023.
//

import Foundation
import UIKit

final class AppearanceManager {
    static func start() {
        setupTabBar()
        setupNavigationBar()
    }
    
    private static func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(.white)
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(.gray)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    private static func setupNavigationBar() {
        let appearance = UINavigationBar.appearance()
        let barButtonItemApperance = UIBarButtonItem.appearance()
        
        appearance.backgroundColor = UIColor(.white)
        appearance.barTintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        appearance.barStyle = .default
        appearance.shadowImage = UIImage()
        
        barButtonItemApperance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -500, vertical: 0),
                                                                    for: UIBarMetrics.default)
        barButtonItemApperance.tintColor = UIColor(.black)
    }
}
