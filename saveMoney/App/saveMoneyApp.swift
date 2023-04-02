//
//  saveMoneyApp.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 27.03.2023.
//

import SwiftUI
import Combine

@main
struct saveMoneyApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
//            ContactsCoordinator(contactsManager: ContactsManager()).view()
            MainView(viewModel: MainViewModel())
        }
    }
}
