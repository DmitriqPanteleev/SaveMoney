//
//  AnalizeCategoryModelMapper.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 29.04.2023.
//

import Foundation

final class AnalizeCategoryModelMapper: BaseModelMapper<ServerAnalyticCategory, AnalizeCategory> {
    override func toLocal(serverEntity: ServerAnalyticCategory) -> AnalizeCategory {
        AnalizeCategory(id: serverEntity.id,
                        name: serverEntity.name.orEmpty(),
                        sum: Int(Double(serverEntity.sum.orEmpty()) ?? -1.0),
                        colorString: serverEntity.color.orEmpty())
        // TODO: - можно получше распределить работу в самой модельке
    }
}
