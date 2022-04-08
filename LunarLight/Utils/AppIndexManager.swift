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
        _id: "9B51960C-0CF2-42CF-BFDC-5CA01232B402",
        _username: "test",
        _email: "test123@gmail.com",
        _password: "12345",
        _year: 2010,
        _month: 1,
        _day: 1,
        _avatar: "capricorn_6")
    
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
    
    case startView = 0, welcomeView, lobbyView, chatView, friendsView, onlineUsersView
    
}
