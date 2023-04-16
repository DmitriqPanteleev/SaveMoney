//
//  QuestionButton.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 03.04.2023.
//

import SwiftUI
import Combine

struct QuestionButton: View {
    
    let actionPublisher: PassthroughSubject<Void, Never>
    let color: Color
    
    var body: some View {
        Button(actionPublisher: actionPublisher) {
            Image(systemName: "questionmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
        }
        .tint(color)
    }
}

struct QuestionButton_Previews: PreviewProvider {
    static var previews: some View {
        QuestionButton(actionPublisher: PassthroughSubject<Void, Never>(),
                       color: .appGreen)
    }
}
