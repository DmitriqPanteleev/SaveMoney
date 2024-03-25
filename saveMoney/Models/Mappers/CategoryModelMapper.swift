//
//  CategoryModelMapper.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 19.04.2023.
//

import Foundation

final class CategoryModelMapper: BaseModelMapper<ServerCategory, Category> {
    override func toLocal(serverEntity: ServerCategory) -> Category {
        Category(id: serverEntity.id,
                 name: serverEntity.name.orEmpty(),
                 colorString: serverEntity.color ?? "000",
                 isCustom: serverEntity.isCustom ?? false)
    }
}
