//
//  AddCategoryView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 20.04.2023.
//

import SwiftUI
import Combine

struct AddCategoryView: View {
    @StateObject var viewModel: AddCategoryViewModel
    
    var body: some View {
        content()
            .navigationTitle(Text("Добавить категорию"))
    }
}

private extension AddCategoryView {
    func content() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Введите название категории: ")
            AppTextField(placeholder: "",
                         text: $viewModel.output.name,
                         style: .description,
                         onChangeText: viewModel.input.onChangeName)
            .padding(.bottom, 16)
            
            ColorPicker(selection: $viewModel.output.color) {
                Text("Выберите цвет категории")
            }
            .onChange(of: viewModel.output.color,
                      perform: sendNewColor)
            Spacer()
            RegularButton(title: .add,
                          onTapAction: viewModel.input.onSaveTap)
        }
        .padding(.top, 24)
        .padding(.horizontal)
        .padding(.bottom, 16)
    }
}

private extension AddCategoryView {
    func sendNewColor(_ color: CGColor) {
        viewModel.input.onChangeColor.send(color)
    }
}

#if DEBUG
struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView(viewModel: AddCategoryViewModel(apiService: CategoryApiService(client: HTTPClientImpl()),
                                                        router: nil))
    }
}
#endif
