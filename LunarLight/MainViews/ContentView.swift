//
//  ContentView.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-01.
//

import Foundation
import SwiftUI

struct ContentView: View {
    
    @ObservedObject var appManager: AppManager
    
    init() {
        appManager = AppManager.singletonObject
        
    }
    
    var body: some View {
        
        VStack{
            
            //navigerar vilken View som ska visas upp.
            
            switch appManager.appIndex {
                
            case AppIndex.startView:
                StartView()
            case AppIndex.welcomeView:
                WelcomeView()
            case AppIndex.lobbyView:
                LobbyTabView()
            case AppIndex.friendsView:
                FriendsView()
            case AppIndex.onlineUsersView:
                OnlineUsersView().transition(.move(edge: .leading))
            case AppIndex.privateChatView:
                PrivateChatView().transition(.move(edge: .leading))
                
            }
        }.animation(.easeIn, value: appManager.appIndex)
    }
}


