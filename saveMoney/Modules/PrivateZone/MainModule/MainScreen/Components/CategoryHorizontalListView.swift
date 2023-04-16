//
//  CategoryHorizontalListView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 02.04.2023.
//

import SwiftUI
import Combine

struct CategoryHorizontalListView: View {
    
    let models: [AnalizeCategory]
    let onDetailAnalizeTap: PassthroughSubject<Void, Never>
    
    var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(models, content: categoryCell)
                }
                .padding(2)
            }
    }
}

private extension CategoryHorizontalListView {
    func categoryCell(_ model: AnalizeCategory) -> some View {
        HStack {
            Text(model.name)
                .font(.footnote)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .cornerRadius(8)
        .overlay(RoundedRectangle(cornerRadius: 8)
            .stroke(model.color, lineWidth: 2))
    }
}

struct CategoryHorizontalListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHorizontalListView(models: [.mock(), .mock2()],
                                   onDetailAnalizeTap: PassthroughSubject<Void, Never>())
    }
}
