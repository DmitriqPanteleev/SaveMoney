//
//  ServerPayment.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 19.04.2023.
//

import Foundation

struct ServerPayment: Codable {
    let id: Int
    let description: String?
    let date: String?
    let sum: Double?
    let categoryId: Int?
    let categoryName: String?
    let categoryColor: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case description
        case date
        case sum
        case category
    }
    
    enum CategoryCodingKeys: String, CodingKey {
        case categoryId
        case categoryName
        case categoryColor
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.description = try container.decode(String.self, forKey: .description)
        self.date = try container.decode(String.self, forKey: .date)
        self.sum = try container.decode(Double.self, forKey: .sum)
        let nested = try container.nestedContainer(keyedBy: CategoryCodingKeys.self,
                                                   forKey: .category)
        self.categoryId = try nested.decode(Int.self, forKey: .categoryId)
        self.categoryName = try nested.decode(String.self, forKey: .categoryName)
        self.categoryColor = try nested.decode(String.self, forKey: .categoryColor)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.date, forKey: .date)
        try container.encode(self.sum, forKey: .sum)
        var nested = container.nestedContainer(keyedBy: CategoryCodingKeys.self,
                                               forKey: .category)
        try nested.encode(self.categoryId, forKey: .categoryId)
        try nested.encode(self.categoryName, forKey: .categoryName)
        try nested.encode(self.categoryColor, forKey: .categoryColor)
    }
}
