//
//  LobbyView.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-01.
//

import SwiftUI
import CoreData

struct LobbyTabView: View {
    
    var body: some View {
        
        TabView {
            
            WorldChatView()
                .tabItem{
                    Image(systemName: "house")
                    Text("World Chat")
                }
            
            FriendsView()
                .tabItem{
                    Image(systemName: "bubble.left.fill")
                    Text("Friends")
                }
            
            ProfileView(_user: AppIndexManager.singletonObject.loggedInUser)
                .tabItem{
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
        }
        .font(.headline)
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
