//
//  AddPaymentView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 03.04.2023.
//

import SwiftUI

struct AddPaymentView: View {
    
    @StateObject var viewModel: AddPaymentViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

private extension AddPaymentView {
    func content() -> some View {
        VStack(spacing: 16) {
            
        }
    }
    
    var desriptionTextField: some View {
        HStack {
            
        }
    }
    
    var desriptionTextField: some View {
        HStack {
            
        }
    }
}

private extension AddPaymentView {
    
}

#if DEBUG
struct AddPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        AddPaymentView(viewModel: AddPaymentViewModel(isEditing: false))
    }
}
#endif
