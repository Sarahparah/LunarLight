//
//  LobbyView.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-01.
//

import SwiftUI
import CoreData


struct LobbyTabView: View {
    
    @StateObject var appIndexManager = AppManager.singletonObject
    
    var body: some View {
        
        TabView(selection: $appIndexManager.currentLobbyTab) {
            
            WorldChatView()
                .tabItem{
                    Image(systemName: "house")
                    Text("World Chat")
                }
                .tag(1)
            
            FriendsView()
                .tabItem{
                    Image(systemName: "bubble.left.fill")
                    Text("Friends")
                }
                .tag(2)
            
            ProfileView()
                .tabItem{
                    Image(systemName: "person.circle").tint(.white)
                    Text("Profile")
                        
                }
                .tag(3)
        }
        .font(.headline)
        .accentColor(.white)
        .onAppear(){
            
            //Listen to friends before user has pressed Friends tab to easier get friends usernames when needed
            AppManager.singletonObject.firestoreFriendModel.listenToFriends()
            appIndexManager.profileUser = appIndexManager.loggedInUser
        }
    }
}

struct LobbyView_Previews: PreviewProvider {
    static var previews: some View {
        LobbyTabView( )
    }
}
