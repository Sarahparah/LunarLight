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
    
    var userName: String = ""
    
    @Published var appIndex = AppIndex.lobbyView
    private init() {
        //SINGLETON. PRIVATE INIT.
    }
    
}

enum AppIndex : Int {
    
    case startView = 0, welcomeView, lobbyView, chatView, lobbyChatView
    
}
