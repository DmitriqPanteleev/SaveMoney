//
//  AnalyticsCoordinator.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 20.04.2023.
//

import SwiftUI
import Stinsen

final class AnalyticsCoordinator: NavigationCoordinatable {
    var stack = NavigationStack(initial: \AnalyticsCoordinator.start)
    
    @Root var start = makeStart
    
    private let apiService: AllAnalyticApiProtocol
    
    init(apiService: AllAnalyticApiProtocol) {
        self.apiService = apiService
    }
    
#if DEBUG
    deinit {
        print("Coordinator \(self) deinited")
    }
#endif
}

extension AnalyticsCoordinator {
    @ViewBuilder func makeStart() -> some View {
        let viewModel = PersonalAnalyticViewModel(apiService: apiService)
        PersonalAnalyticView(viewModel: viewModel)
//        PersonalAnalyticView(categories: [.mock(), .mock2(), .mock3(), .mock4()], payments: [.emptyWithSum(2000, .init(timeIntervalSince1970: 1680395737)),.emptyWithSum(1000, .init(timeIntervalSince1970: 1680568537)),.emptyWithSum(3000, .init(timeIntervalSince1970: 1680827737)),.emptyWithSum(3400, .init(timeIntervalSince1970: 1681173337)),.emptyWithSum(2130, .init(timeIntervalSince1970: 1681432537)),.emptyWithSum(10000, .init(timeIntervalSince1970: 1681778137))], food: [.emptyWithSum(300, .init(timeIntervalSince1970: 1680395737)),.emptyWithSum(200, .init(timeIntervalSince1970: 1680568537)),.emptyWithSum(400, .init(timeIntervalSince1970: 1680827737)),.emptyWithSum(700, .init(timeIntervalSince1970: 1681173337)),.emptyWithSum(250, .init(timeIntervalSince1970: 1681432537)),.emptyWithSum(870, .init(timeIntervalSince1970: 1681778137))], auto: [.emptyWithSum(500, .init(timeIntervalSince1970: 1680395737)),.emptyWithSum(1000, .init(timeIntervalSince1970: 1680568537)),.emptyWithSum(300, .init(timeIntervalSince1970: 1680827737)),.emptyWithSum(500, .init(timeIntervalSince1970: 1681173337)),.emptyWithSum(500, .init(timeIntervalSince1970: 1681432537)),.emptyWithSum(500, .init(timeIntervalSince1970: 1681778137))], network: [.emptyWithSum(2000, .init(timeIntervalSince1970: 1680395737)),.emptyWithSum(1000, .init(timeIntervalSince1970: 1680568537))])
    }
}
