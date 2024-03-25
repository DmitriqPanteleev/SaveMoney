//
//  CategoriesRouter.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 27.04.2023.
//

import Foundation

protocol CategoriesRouter: AnyObject {
    func pushToAddCategory()
    func pushToEditCategory(categoryId: Int)
}

extension CategoriesCoordinator: CategoriesRouter {
    func pushToAddCategory() {
        self.route(to: \.addCategory)
    }
    
    func pushToEditCategory(categoryId: Int) {
        
    }
    
}
