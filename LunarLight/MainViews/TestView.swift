//
//  StoneTestView.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-07.
//

import SwiftUI

struct TestView: View {
    
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
                    Text("< Back")
                }
                
                Button {
                    AppIndexManager.singletonObject.logout()
                } label: {
                    Text("Logout")
                }

            }
            
            List{
                ForEach (firestoreUserModel.usersOnline) { userOnline in
                    
                    HStack{
                        Text(userOnline.username)
                        Text("Online")
                        Color.green
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
        TestView()
    }
}
