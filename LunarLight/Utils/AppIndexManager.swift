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
    
    let testUser = UserFirebase(
        _id: "6DF4FC1D-3A34-42CD-A63B-568B8C4A21C5",
        _username: "testuser",
        _email: "Test@email.se",
        _password: "12345",
        _year: 2000,
        _month: 4,
        _day: 7,
        _avatar: "aries_5")
    
    var currentUser: UserFirebase
    var profileUser: UserFirebase?
    
    @Published var appIndex = AppIndex.lobbyView
    
    private init() {
        //SINGLETON. PRIVATE INIT.
        currentUser = testUser
    }
    
    func logout() {
        
        let currentUserOnline = UserOnlineFirebase(_id: currentUser.id, _username: currentUser.username, _isOnline: false)
        let firebaseUserOnlineModel = FirestoreUserOnlineModel()
        firebaseUserOnlineModel.updateOnlineUser(currentUserOnline: currentUserOnline)
        
        currentUser = testUser
        AppIndexManager.singletonObject.appIndex = AppIndex.startView
        print("Logged out!")
    }
    
}

enum AppIndex : Int {
    
    case startView = 0, welcomeView, lobbyView, chatView, lobbyChatView, onlineUsersView
    
}
