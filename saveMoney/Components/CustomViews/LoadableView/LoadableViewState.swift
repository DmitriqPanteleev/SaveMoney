//
//  LoadableViewState.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 16.04.2023.
//

import Foundation

enum LoadableViewState: Equatable {
    case processing
    case error(message: String?)
    case content
    case internetDisabled
}
