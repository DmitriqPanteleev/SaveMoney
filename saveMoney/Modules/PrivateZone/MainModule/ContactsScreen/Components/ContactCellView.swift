//
//  ContactCellView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 29.03.2023.
//

import SwiftUI

struct ContactCellView: View {
    
    let model: Contact
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(model.nickname)
                .lineLimit(1)
            
            Text(model.phoneNumber)
                .lineLimit(1)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct ContactCellView_Previews: PreviewProvider {
    static var previews: some View {
        ContactCellView(model: .mock())
            .background(Color.gray.opacity(0.2).ignoresSafeArea())
    }
}
