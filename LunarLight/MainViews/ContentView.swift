//
//  ContentView.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-01.
//

import Foundation
import SwiftUI

struct ContentView: View {

    @ObservedObject var appIndexManager: AppIndexManager
    
    init() {
        appIndexManager = AppIndexManager.singletonObject
        
        let preferences = UserDefaults.standard
        let currentUserIdKey = "currentUserId"
        if preferences.object(forKey: currentUserIdKey) == nil {
            initiateCurrentUserId()
        }
    }
    
    var body: some View {
        
        
        switch appIndexManager.appIndex {
            
        case AppIndex.startView:
            StartView()
        case AppIndex.welcomeView:
            WelcomeView()
        case AppIndex.lobbyView:
            LobbyView()
        case AppIndex.chatView:
            ChatView()
        case AppIndex.lobbyChatView:
            LobbyChatView()
        
        }
        
    }
    
    private func initiateCurrentUserId() {
        
        let preferences = UserDefaults.standard

        let currentUserIdKey = "currentUserId"

        let currentUserId = 1
        preferences.set(currentUserId, forKey: currentUserIdKey)

        //  Save to disk
        let didSave = preferences.synchronize()

        if !didSave {
            //  Couldn't save (I've never seen this happen in real world testing)
        }
    }
}


