//
//  RegistrationModelMapper.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 17.04.2023.
//

import Foundation

final class RegistrationModelMapper: BaseModelMapper<RegistrationResponse, RegistrationModel> {
    override func toLocal(serverEntity: RegistrationResponse) -> RegistrationModel {
        RegistrationModel(email: serverEntity.email.orEmpty(),
                          token: serverEntity.token.orEmpty())
    }
}
