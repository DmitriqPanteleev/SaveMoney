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
        .overlay(content: datePicker)
        .animation(.default, value: viewModel.output.isShowingDatePicker)
    }
    
    var topBlock: some View {
        VStack(spacing: 8) {
            Text(viewModel.output.date.formatted(date: .complete,
                                                 time: .shortened))
            .foregroundColor(.appGray)
            .font(.system(size: 12))
            .onTapGesture {
                viewModel.input.onDateChange.send(Date.now)
            }
            
            Text(viewModel.output.sum.isEmpty ? "\(0)₽" : "\(viewModel.output.sum)₽")
                .foregroundColor(.black)
                .font(.system(size: 42, weight: .semibold))
                .onTapGesture {
                    viewModel.input.onSumChange.send("")
                }
            description
        }
        .padding(.top, 32)
        .padding(.bottom, 32)
        //        .padding(.vertical, 72)
    }
    
    @ViewBuilder var description: some View {
//        if !viewModel.output.description.isEmpty {
//            Text(viewModel.output.description)
//                .foregroundColor(.appGray)
//                .font(.system(size: 12))
//                .padding(.horizontal, 32)
//                .lineLimit(1)
//        } else {
//            Button(action: {}) {
//                Text("Введите описание")
//                    .foregroundColor(.appGray)
//                    .font(.system(size: 12))
//                    .padding(.horizontal, 32)
//                    .lineLimit(1)
//            }
//            .tint(.appGray)
//        }
        ZStack {
            Text(viewModel.output.description)
                            .foregroundColor(.appGray)
                            .font(.system(size: 12))
                            .padding(.horizontal, 32)
                            .lineLimit(1)
            textKeyboard()
        }
        
    }
    var categoriesControl: some View {
        CategoryPickerView(models: viewModel.output.categories,
                           onCategoryChange: viewModel.input.onCategoryChange)
    }
    
    func keyboardPanel() -> some View {
        KeyboardControlView(isShowing: $viewModel.output.isShowingAppKeyboard,
                            sum: $viewModel.output.sum,
                            onTypeChange: viewModel.input.onTabSectionChange,
                            onSumChange: viewModel.input.onSumChange,
                            onDoneTap: viewModel.input.onSaveButtonTap)
    }
    
    @ViewBuilder func datePicker() -> some View {
        VStack {
            Spacer()
            if viewModel.output.isShowingDatePicker {
                DatePicker(selection: $viewModel.output.date,
                           displayedComponents: .date,
                           label: {
                })
                .datePickerStyle(.wheel)
                .padding(.bottom, 40)
                .padding(.trailing, 32)
            }
            
        }
    }
    
    @ViewBuilder func textKeyboard() -> some View {
        InvisibleKeyboard(text: $viewModel.output.description,
                          onChangeText: viewModel.input.onDescriptionChange,
                          onFieldTap: viewModel.input.onTextFieldTap)
    }
}

private extension AddPaymentView {
    
}

#if DEBUG
struct AddPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        AddPaymentView(viewModel: AddPaymentViewModel(isEditing: false, categoryApiService: CategoryApiService(client: HTTPClientImpl()), apiService: PaymentApiService(client: HTTPClientImpl()), router: nil))
    }
}
#endif
