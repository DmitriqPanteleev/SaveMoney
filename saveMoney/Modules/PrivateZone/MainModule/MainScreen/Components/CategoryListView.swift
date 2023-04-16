//
//  CategoryListView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 01.04.2023.
//

import SwiftUI
import Combine

struct CategoryListView: View {
    
    let models: [AnalizeCategory]
    let onTapPublisher: PassthroughSubject<AnalizeCategory, Never>
    let onAddCategory: PassthroughSubject<Void, Never>
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(models, content: categoryCellView)
                    .padding(.horizontal)
                    .padding(.top, 4)
                addCategoryButtonView
                    .padding(.bottom, 4)
            }
        }
    }
}

private extension CategoryListView {
    func categoryCellView(_ model: AnalizeCategory) -> some View {
        Button(actionPublisher: onTapPublisher,
               sendableModel: model){
            HStack(spacing: 10) {
                coloredRingView(model)
                Text(model.name)
                Spacer()
                Text(model.formattedSum)
                    .foregroundColor(.gray)
            }
            .frame(height: 36)
        }
        .tint(Color.black)
    }
    
    func coloredRingView(_ model: AnalizeCategory) -> some View {
        ZStack {
            Circle()
                .frame(width: 12)
                .foregroundColor(model.color)
            
            Circle()
                .frame(width: 8)
                .foregroundColor(.white)
        }
    }
    
    var addCategoryButtonView: some View {
        Button(actionPublisher: onAddCategory) {
            HStack {
                HStack(spacing: 10) {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 14)
                    Text("Добавить категорию")
                    Spacer()
                }
                .frame(height: 36)
                .padding(.horizontal)
            }
        }
        .tint(Color.gray)
    }
}

#if DEBUG
struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView(models: [.mock(),
                                  .mock2(),
                                  .mock3(),
                                  .mock4()],
                         onTapPublisher: PassthroughSubject<AnalizeCategory, Never>(),
                         onAddCategory: PassthroughSubject<Void, Never>())
    }
}
#endif
