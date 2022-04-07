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
    
    var currentUser: UserFirebase
    
    @Published var appIndex = AppIndex.startView
    
    private init() {
        //SINGLETON. PRIVATE INIT.
        currentUser = UserFirebase(_id: "", _username: "testuser", _email: "test@gmail.com", _password: "123", _year: 1999, _month: 03, _day: 31, _avatar: "Bengan")
    }
    
}

enum AppIndex : Int {
    
    case startView = 0, welcomeView, lobbyView, chatView, lobbyChatView
    
}
