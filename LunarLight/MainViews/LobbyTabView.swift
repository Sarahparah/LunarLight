//
//  LobbyView.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-01.
//

import SwiftUI
import CoreData


struct LobbyTabView: View {
    
    @StateObject var appIndexManager = AppIndexManager.singletonObject
    
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
            
            ProfileView(_user: AppIndexManager.singletonObject.loggedInUser)
                .tabItem{
                    Image(systemName: "person.circle").tint(.white)
                    Text("Profile")
                        
                }
                .tag(3)
        }
        .font(.headline)
        .accentColor(.white)
        .onAppear(){
                
            AppIndexManager.singletonObject.firestoreFriendModel.listenToFriends()
        }
    }
}

struct LobbyView_Previews: PreviewProvider {
    static var previews: some View {
        LobbyTabView( )
    }
}
