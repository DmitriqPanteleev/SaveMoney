//
//  TabBarCoordinator.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 18.04.2023.
//

import SwiftUI
import Stinsen

final class TabBarCoordinator: TabCoordinatable {
    var child = TabChild.init(startingItems: [
        \TabBarCoordinator.home,
         \TabBarCoordinator.categories,
         \TabBarCoordinator.analytics
    ])
    
    @Route(tabItem: makeHomeTab) var home = makeHome
    @Route(tabItem: makeCategoriesTab) var categories = makeCategories
    @Route(tabItem: makeAnalyticsTab) var analytics = makeAnalytics
    
    private let categoryApiService = DIContainer.shared.container.resolve(CategoryApiService.self)!
#if DEBUG
    deinit {
        print("Coordinator \(self) deinited")
    }
#endif
    
    func customize(_ view: AnyView) -> some View {
        view
            .tint(ColorsPalette.shared.lightOrange)
    }
}

extension TabBarCoordinator {
    func makeHome() -> NavigationViewCoordinator<HomeCoordinator> {
        NavigationViewCoordinator(HomeCoordinator(categoryApiService: categoryApiService))
    }
    
    @ViewBuilder func makeHomeTab(isActive: Bool) -> some View {
        VStack {
            Image(systemName: "house")
            Text("Главная")
        }
    }
    
    func makeAnalytics() -> NavigationViewCoordinator<AnalyticsCoordinator> {
        NavigationViewCoordinator(AnalyticsCoordinator())
    }
    
    @ViewBuilder func makeAnalyticsTab(isActive: Bool) -> some View {
        VStack {
            Image(systemName: "chart.bar.xaxis")
            Text("Аналитика")
        }
    }
    
    func makeCategories() -> NavigationViewCoordinator<CategoriesCoordinator> {
        NavigationViewCoordinator(CategoriesCoordinator(categoryApiService: categoryApiService))
    }
    
    @ViewBuilder func makeCategoriesTab(isActive: Bool) -> some View {
        VStack {
            Image(systemName: "list.bullet.rectangle.fill")
            Text("Категории")
        }
    }
}
