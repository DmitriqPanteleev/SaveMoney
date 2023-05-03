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
    let date: String?
    let sum: Double?
    
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
        var container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        var nested = try container.nestedContainer(keyedBy: CategoryCodingKeys.self,
                                                   forKey: .category)
        self.name = try nested.decode(String.self, forKey: .name)
        self.color = try nested.decode(String.self, forKey: .color)
        self.date = try container.decode(String.self, forKey: .date)
        self.sum = try container.decode(Double.self, forKey: .sum)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        var nested = container.nestedContainer(keyedBy: CategoryCodingKeys.self,
                                               forKey: .category)
        try nested.encode(self.name, forKey: .name)
        try nested.encode(self.color, forKey: .color)
        try container.encode(self.date, forKey: .date)
        try container.encode(self.sum, forKey: .sum)
    }
}
