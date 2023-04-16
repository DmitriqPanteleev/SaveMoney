//
//  TransactionTabView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 10.04.2023.
//

import SwiftUI
import Combine

struct TransactionTabView: View {
    
    @State var activeSection: TabSection = .outcomes
    let onChangeType: PassthroughSubject<TabSection, Never>
    
    var body: some View {
        tabSectionView
    }
}

private extension TransactionTabView {
    var tabSectionView: some View {
        ZStack {
            
            HStack {
                if activeSection == .outcomes {
                    Spacer()
                }
                // TODO: - сменить ширину на адаптив
                RoundedRectangle(cornerRadius: 18)
                    .frame(width: 185, height: 34)
                    .foregroundColor(.white)
                if activeSection == .incomes {
                    Spacer()
                }
            }
            .padding(.horizontal, 6)
            .animation(.spring(response: 0.2,
                               dampingFraction: 0.5,
                               blendDuration: 0.1),
                       value: activeSection)
            
            HStack(spacing: 110) {
                Text("Доход")
                    .foregroundColor(activeSection == .incomes ? .black : .appGray)
                    .onTapGesture {
                        onChangeType.send(.outcomes)
                        activeSection = .incomes
                    }
                
                Text("Расход")
                    .foregroundColor(activeSection == .outcomes ? .black : .appGray)
                    .onTapGesture {
                        onChangeType.send(.outcomes)
                        activeSection = .outcomes
                    }
            }
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
        }
        .background(Color.black.opacity(0.04))
        .cornerRadius(200)
    }
}

#if DEBUG
struct TransactionTabView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionTabView(onChangeType: PassthroughSubject<TabSection, Never>())
            .padding(.horizontal)
    }
}
#endif
