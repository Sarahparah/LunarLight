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
    
    let firestoreFriendModel = FirestoreFriendModel()
    
    var timerWorkItem: DispatchWorkItem?
    
    let testUser = UserFirebase(
        _id: "7D59D875-E3F4-4396-91DC-20309FD68195",
        _username: "test",
        _email: "test@email.se",
        _password: "12345",
        _year: 2010,
        _month: 1,
        _day: 1,
        _avatar: "capricorn_6")
    
    var currentUser: UserFirebase
    var profileUser: UserFirebase?
    var privateChatUser : UserFirebase?
    
    @Published var appIndex = AppIndex.startView
    
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
    
    func resetTimer() {
        print("timeout: in process")
                        
        // set timer
        timerWorkItem = DispatchWorkItem {
            //AppIndexManager.singletonObject.logout()
            print("timed out!")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 60, execute: timerWorkItem!)
    }
}

enum AppIndex : Int {
    
    case startView = 0, welcomeView, lobbyView, chatView, friendsView, onlineUsersView, privateChatView
    
}
