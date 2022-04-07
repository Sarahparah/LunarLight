//
//  AppStateController.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-01.
//

import Foundation
import SwiftUI

class AppIndexManager: ObservableObject {
    
    static let singletonObject = AppIndexManager()
    
    var currentUser: UserFirebase?
    
    @Published var appIndex = AppIndex.startView
    
    private init() {
        //SINGLETON. PRIVATE INIT.
    }
    
}

enum AppIndex : Int {
    
    case startView = 0, welcomeView, lobbyView, chatView, lobbyChatView
    
}
