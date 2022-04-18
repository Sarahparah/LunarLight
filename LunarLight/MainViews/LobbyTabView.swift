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
                        .colorMultiply(.white)
                    Text("World Chat")
                }
                .tag(1)
            
            FriendsView()
                .tabItem{
                    Image(systemName: "bubble.left.fill")
                    Text("Friends")
                        .foregroundColor(.white)
                }
                .tag(2)
            
            ProfileView(_user: AppIndexManager.singletonObject.loggedInUser)
                .tabItem{
                    Image(systemName: "person.circle")
                    Text("Profile")
                        .foregroundColor(.white)
                }
                .tag(3)
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
