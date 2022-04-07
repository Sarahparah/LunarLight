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
    
    @State var timerWorkItem: DispatchWorkItem?
    
    init() {
        appIndexManager = AppIndexManager.singletonObject
        
        let preferences = UserDefaults.standard
        let currentUserIdKey = "currentUserId"
        if preferences.object(forKey: currentUserIdKey) == nil {
            initiateCurrentUserId()
        }
    }
    
    var body: some View {
        
        VStack{
            
            switch appIndexManager.appIndex {
                
            case AppIndex.startView:
                StartView()
            case AppIndex.welcomeView:
                WelcomeView()
                    .onAppear(perform: resetTimer)
            case AppIndex.lobbyView:
                LobbyView()
                    .onAppear(perform: resetTimer)
            case AppIndex.chatView:
                ChatView()
                    .onAppear(perform: resetTimer)
            case AppIndex.lobbyChatView:
                LobbyChatView()
                    .onAppear(perform: resetTimer)
            case AppIndex.onlineUsersView:
                OnlineUsersView()
                    .onAppear(perform: resetTimer)
            
            }
            
        }
        

    }
    
    private func resetTimer() {
        print("timeout: in process")
                        
        // set timer
        timerWorkItem = DispatchWorkItem {
            //AppIndexManager.singletonObject.logout()
            print("timed out!")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 60, execute: timerWorkItem!)
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


