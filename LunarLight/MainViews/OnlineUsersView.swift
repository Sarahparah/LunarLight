//
//  StoneTestView.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-07.
//

import SwiftUI

struct OnlineUsersView: View {
    
    @StateObject var firestoreUserModel = FirestoreUserModel()
    
    init() {
        
    }
    
    var body: some View {
        
        VStack {
            Text("Test View")
            
            HStack{
                Button {
                    AppIndexManager.singletonObject.appIndex = AppIndex.lobbyView
                } label: {
                    Text("< Lobby")
                }
                
                Spacer()
                
                Button {
                    AppIndexManager.singletonObject.logout()
                } label: {
                    Text("Logout")
                }

            }.padding()
            
            List{
                ForEach (firestoreUserModel.usersOnline) { userOnline in
                    
                    HStack{
                        Text(userOnline.username)
                        Spacer()
                        Text("Online")
                        Color.green
                            .frame(width: 25, height: 25)
                            .cornerRadius(100)
                            
                    }
                }
            }
        }.onAppear {
            firestoreUserModel.listenToOnlineUsers()
        }
        
        
    }
}

struct StoneTestView_Previews: PreviewProvider {
    static var previews: some View {
        OnlineUsersView()
    }
}
