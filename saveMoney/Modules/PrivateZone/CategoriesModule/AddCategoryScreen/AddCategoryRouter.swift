//
//  AddCategoryRouter.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 28.04.2023.
//

import Foundation

protocol AddCategoryRouter: AnyObject {
    func back()
}

extension CategoriesCoordinator: AddCategoryRouter {
    func back() {
        self.popLast(nil)
    }
}
