//
//  AddPaymentView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 03.04.2023.
//

import SwiftUI
import Combine

struct AddPaymentView: View {
    
    @StateObject var viewModel: AddPaymentViewModel
    
    var body: some View {
        LoadableView(state: viewModel.output.screenState,
                     content: content,
                     onAppearDidLoad: viewModel.input.onAppear)
    }
}

private extension AddPaymentView {
    func content() -> some View {
        VStack(spacing: 0) {
            topBlock
            categoriesControl
            Spacer()
        }
        .padding(.horizontal)
        .overlay(content: keyboardPanel)
    }
    
    var topBlock: some View {
        VStack(spacing: 8) {
            Text(viewModel.output.date.formatted(date: .complete,
                                                 time: .shortened))
            .foregroundColor(.appGray)
            .font(.system(size: 12))
            
            Text(viewModel.output.sum.isEmpty ? "\(0)₽" : "\(viewModel.output.sum)₽")
            .foregroundColor(.black)
            .font(.system(size: 42, weight: .semibold))
            
            description
        }
        .padding(.vertical, 72)
    }
    
    @ViewBuilder var description: some View {
        if let description = viewModel.output.description {
            Text(description)
            .foregroundColor(.appGray)
            .font(.system(size: 12))
            .padding(.horizontal, 32)
            .lineLimit(1)
        } else {
            Button(action: {}) {
                Text("Введите описание")
                .foregroundColor(.appGray)
                .font(.system(size: 12))
                .padding(.horizontal, 32)
                .lineLimit(1)
            }
            .tint(.appGray)
        }
    }
    var categoriesControl: some View {
        CategoryPickerView(models: viewModel.output.categories,
                           onCategoryChange: viewModel.input.onCategoryChange)
    }
    
    func keyboardPanel() -> some View {
        KeyboardControlView(sum: $viewModel.output.sum,
                            onTypeChange: viewModel.input.onTabSectionChange,
                            onSumChange: viewModel.input.onSumChange,
                            onDoneTap: viewModel.input.onSaveButtonTap)
    }
}

private extension AddPaymentView {
    
}

#if DEBUG
struct AddPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        AddPaymentView(viewModel: AddPaymentViewModel(isEditing: false, categoryApiService: CategoryApiService(client: HTTPClientImpl()), apiService: PaymentApiService(client: HTTPClientImpl())))
    }
}
#endif
