//
//  AddCategoryView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 20.04.2023.
//

import SwiftUI
import Combine

struct AddCategoryView: View {
    @State var name = "Техника"
    @State var color: CGColor = .init(red: 0.5,
                                      green: 0.3,
                                      blue: 0.81, alpha: 1)
    
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
                         text: $name,
                         style: .description,
                         onChangeText: PassthroughSubject<String, Never>())
            .padding(.bottom, 16)
            ColorPicker(selection: $color) {
                Text("Выберите цвет категории")
            }
            Spacer()
            RegularButton(title: .add, onTapAction: PassthroughSubject<Void, Never>())
        }
        .padding(.top, 24)
        .padding(.horizontal)
        .padding(.bottom, 16)
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView()
    }
}
