//
//  Button + Extensions.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 29.03.2023.
//

import SwiftUI
import Combine

extension Button {
    init(actionPublisher: PassthroughSubject<Void, Never>, label: @escaping () -> Label) {
        self.init(action: {
            actionPublisher.send()
        }, label: label)
    }
    
    init<T>(actionPublisher: PassthroughSubject<T, Never>,
            sendableModel model: T,
            label: @escaping () -> Label) {
        self.init(action: {
            actionPublisher.send(model)
        }, label: label)
    }
}
