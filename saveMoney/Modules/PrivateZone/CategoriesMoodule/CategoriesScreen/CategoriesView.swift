//
//  CategoriesView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 20.04.2023.
//

import SwiftUI

struct CategoriesView: View {
    
    @StateObject var viewModel: CategoriesViewModel
    
    var body: some View {
        LoadableView(state: viewModel.output.screenState,
                     content: content,
                     onAppearDidLoad: viewModel.input.onAppear)
            .navigationTitle(Text("Категории"))
    }
}

private extension CategoriesView {
    func content() -> some View {
        categoryListView
            .padding(.horizontal)
    }
    
    var categoryListView: some View {
        VStack {
            ForEach(viewModel.output.categories) { model in
                HStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .frame(width: 12)
                            .foregroundColor(model.color)
                        
                        Circle()
                            .frame(width: 8)
                            .foregroundColor(.white)
                    }
                    
                    Text(model.name)
                    Spacer()
                    if model.isCustom {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(ColorsPalette.shared.lightOrange)
                            .frame(width: 14,
                                   height: 14)
                    }
                }
                .frame(height: 44)
            }
            Spacer()
        }
    }
}

#if DEBUG
struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(viewModel: CategoriesViewModel(apiService: CategoryApiService(client: HTTPClientImpl()), router: nil))
    }
}
#endif
