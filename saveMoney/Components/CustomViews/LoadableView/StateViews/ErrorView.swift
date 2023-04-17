//
//  ErrorView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 16.04.2023.
//

import SwiftUI
import Combine

struct ErrorView: View {
    
    let errorMesssage: String
    let onTapAction: PassthroughSubject<Void, Never>
    
    var body: some View {
        VStack {
            Spacer()
            Text(errorMesssage)
            Spacer()
            RegularButton(title: .retry, onTapAction: onTapAction)
        }
        .padding(.bottom, 10)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorMesssage: "Случилось что-то плохое",
                  onTapAction: PassthroughSubject<Void, Never>())
    }
}
