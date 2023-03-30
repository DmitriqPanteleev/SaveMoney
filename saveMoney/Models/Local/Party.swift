//
//  Party.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 28.03.2023.
//

import Foundation

struct Party {
    let id: Int
    let commonSum: Int
    let isClosed: Bool
    let members: [PartyMember]
}

struct PartyMember {
    let id: Int
    let name: String
    let sum: Int
}

/*
 {
    data: {
        members: {
            {
                id: Int,
                phone...
                sum: Int
            },
            {
                id: Int,
                phone...
                sum: Int
            }
        },
        commonSum: Int
        isClosed: Bool
    }
 }
 */
