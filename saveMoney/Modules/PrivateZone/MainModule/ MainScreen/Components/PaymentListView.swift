//
//  PaymentListView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 02.04.2023.
//

import SwiftUI
import Combine

struct PaymentListView: View {
    let models: [Payment]
    let onTapPublisher: PassthroughSubject<Payment, Never>
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(models, content: paymentCellView)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
            }
        }
    }
}

private extension PaymentListView {
    func paymentCellView(_ model: Payment) -> some View {
        Button(actionPublisher: onTapPublisher,
               sendableModel: model){
            HStack(spacing: 10) {
                coloredRingView(model)
                VStack(alignment: .leading, spacing: 4) {
                    Text(model.category)
                    Text(model.date?.formatted(date: .abbreviated,
                                               time: .shortened) ?? "")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                Spacer()
                Text(model.formattedSum)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .frame(height: 36)
            .padding(.vertical, 8)
        }
        .tint(Color.black)
    }
    
    func coloredRingView(_ model: Payment) -> some View {
        ZStack {
            Circle()
                .frame(width: 12)
                .foregroundColor(model.categoryColor)
            
            Circle()
                .frame(width: 8)
                .foregroundColor(.white)
        }
    }
}

#if DEBUG
struct PaymentListView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentListView(models: [.mock(), .mock2(), .mock3()],
                        onTapPublisher: PassthroughSubject<Payment, Never>())
    }
}
#endif
