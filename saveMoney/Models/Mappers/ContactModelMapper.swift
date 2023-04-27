//
//  ContactModelMapper.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 19.04.2023.
//

import Foundation

final class ContactModelMapper: BaseModelMapper<ServerContact, Contact> {
    override func toLocal(serverEntity: ServerContact) -> Contact {
        Contact(id: serverEntity.id,
                nickname: serverEntity.nick.orEmpty(),
                phoneNumber: serverEntity.nick.orEmpty())
    }
}
