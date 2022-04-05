//
//  LobbyView.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-01.
//

import SwiftUI

struct LobbyView: View {
    
    var body: some View {
        
        TabView {
            
            Text("Lobby View")
                .tabItem{
                    Image(systemName: "house")
                    Text("Chat")
                }
            
            LobbyChatView()
                .tabItem{
                    Image(systemName: "bubble.left.fill")
                    Text("Lobby chat")
                }
            
            ProfileView()
                .tabItem{
                    Image(systemName: "gearshape.fill")
                    Text("Profile")
                    
                }
        }
        .font(.headline)
    }
}

struct LobbyView_Previews: PreviewProvider {
    static var previews: some View {
        LobbyView( )
    }
}
