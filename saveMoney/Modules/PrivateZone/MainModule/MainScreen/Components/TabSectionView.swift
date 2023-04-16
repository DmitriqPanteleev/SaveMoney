//
//  TabSectionView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 01.04.2023.
//


// TODO: - СДЕЛАТЬ ПЕРЕЛИВАНИЕ
import SwiftUI

struct TabSectionView: View {
    
    @State var currentSection: TabSection
    
    var body: some View {
        HStack(spacing: 4) {
            outcomeButtonView
            icomeButtonView
        }
        // TODO: написать отдельный компонент
//        .animation(.easeOut(duration: 0.2),
//                   value: currentSection)
    }
}

private extension TabSectionView {
    var icomeButtonView: some View {
        Text("Расходы")
            .frame(width: 100, height: 32)
//            .overlay(RoundedRectangle(cornerRadius: 10)
//                .stroke(Color.gray.opacity(currentSection == .incomes ? 0 : 0.5), lineWidth: 2))
            .background(currentSection == .outcomes ? Color.white : Color.clear)
            .cornerRadius(currentSection == .outcomes ? 10 : 0)
            .shadow(radius: currentSection == .outcomes ? 4 : 0,
                    y: currentSection == .outcomes ? 2 : 0)
            .onTapGesture {
                currentSection = .outcomes
            }
    }
    
    var outcomeButtonView: some View {
        Text("Доходы")
            .frame(width: 100, height: 32)
//            .overlay(RoundedRectangle(cornerRadius: 10)
//                .stroke(Color.gray.opacity(currentSection == .incomes ? 0.5 : 0), lineWidth: 2))
            .background(currentSection == .incomes ? Color.white : Color.clear)
            .cornerRadius(currentSection == .incomes ? 10 : 0)
            .shadow(radius: currentSection == .incomes ? 4 : 0,
                    y: currentSection == .incomes ? 2 : 0)
            .onTapGesture {
                currentSection = .incomes
            }
    }
}

#if DEBUG
struct TabSectionView_Previews: PreviewProvider {
    static var previews: some View {
        TabSectionView(currentSection: TabSection.incomes)
    }
}
#endif
