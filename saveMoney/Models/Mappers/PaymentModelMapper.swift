//
//  PaymentModelMapper.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 19.04.2023.
//

import SwiftUI

final class PaymentModelMapper: BaseModelMapper<ServerPayment, Payment> {
    override func toLocal(serverEntity: ServerPayment) -> Payment {
        Payment(id: serverEntity.id,
                description: serverEntity.description.orEmpty(),
                date: serverEntity.date.orEmpty().toDate() ?? .distantFuture,
                sum: Int(serverEntity.sum ?? -1),
                categoryId: serverEntity.categoryId ?? -1,
                categoryName: serverEntity.categoryName.orEmpty(),
                categoryColor: toColor(serverEntity.categoryColor))
    }
}

func toColor(_ value: String?) -> Color{
    if let color = value {
        return Color.init(hex: color)
    } else {
        return Color.black
    }
}
