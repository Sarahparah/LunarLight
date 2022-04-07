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
    
    let testUser = UserFirebase(_id: "", _username: "testuser", _email: "test@gmail.com", _password: "123", _year: 1999, _month: 4, _day: 25, _avatar: "Bengan")
    var currentUser: UserFirebase
    
    @Published var appIndex = AppIndex.onlineUsersView
    
    private init() {
        //SINGLETON. PRIVATE INIT.
        currentUser = testUser
    }
    
    func logout() {
        
        let currentUserOnline = UserOnlineFirebase(_id: currentUser.id, _username: currentUser.username, _isOnline: false)
        let firebaseUserModel = FirestoreUserModel()
        firebaseUserModel.updateOnlineUser(currentUserOnline: currentUserOnline)
        
        currentUser = testUser
        AppIndexManager.singletonObject.appIndex = AppIndex.startView
        print("Logged out!")
    }
    
}

enum AppIndex : Int {
    
    case startView = 0, welcomeView, lobbyView, chatView, lobbyChatView, onlineUsersView
    
}
