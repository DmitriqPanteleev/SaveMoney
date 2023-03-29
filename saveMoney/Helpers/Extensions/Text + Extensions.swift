//
//  Text + Extensions.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 29.03.2023.
//

import SwiftUI

extension Text {
    init(_ text: Strings, locale: Language = .russian) {
        self.init(text.rawValue.localized(locale))
    }
}
