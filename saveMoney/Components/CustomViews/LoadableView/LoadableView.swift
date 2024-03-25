//
//  LoadableView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 16.04.2023.
//

import SwiftUI
import Combine

struct LoadableView<Content: View>: View {
    let state: LoadableViewState
    let content: Content
    let onAppearDidLoad: PassthroughSubject<Void, Never>
    let repeatButtonTap: PassthroughSubject<Void, Never>
    let goRouterTap: PassthroughSubject<Void, Never>
    
    init(state: LoadableViewState,
         @ViewBuilder content: () -> Content,
         onAppearDidLoad: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>(),
         repeatButtonTap: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>(),
         goRouterTap: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()) {
        self.state = state
        self.content = content()
        self.onAppearDidLoad = onAppearDidLoad
        self.repeatButtonTap = repeatButtonTap
        self.goRouterTap = goRouterTap
    }
    
    var body: some View {
        VStack {
            switch state {
            case .processing:
                LoadingView()
            case .error(let message):
                ErrorView(errorMesssage: message ?? "Что-то пошло не так",
                          onTapAction: repeatButtonTap)
            case .content:
                content
            case .internetDisabled:
                ErrorView(errorMesssage: "Интернет-соединение потеряно",
                          onTapAction: repeatButtonTap)
            }
        }
        .onAppear(perform: onAppear)
    }
}

extension LoadableView {
    
    func onAppear() {
        onAppearDidLoad.send()
    }
}

struct LoadableView_Previews: PreviewProvider {
    static var previews: some View {
        LoadableView(state: .content) {
            Text("Test")
        }
    }
}

