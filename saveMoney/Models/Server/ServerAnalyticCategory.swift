//
//  ServerAnalyticCategory.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 29.04.2023.
//

import Foundation

struct ServerAnalyticCategory: Codable {
    let id: Int
    let name: String?
    let color: String?
    let sum: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case category
        case description
        case date
        case sum
    }
    
    enum CategoryCodingKeys: String, CodingKey {
        case id
        case name
        case color
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.sum = try container.decode(String.self, forKey: .sum)
        let nested = try container.nestedContainer(keyedBy: CategoryCodingKeys.self,
                                                   forKey: .category)
        self.name = try nested.decode(String.self, forKey: .name)
        self.color = try nested.decode(String.self, forKey: .color)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        var nested = container.nestedContainer(keyedBy: CategoryCodingKeys.self,
                                               forKey: .category)
        try nested.encode(self.name, forKey: .name)
        try nested.encode(self.color, forKey: .color)
        try container.encode(self.sum, forKey: .sum)
    }
}
