//
//  LobbyView.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-01.
//

import SwiftUI

struct LobbyView: View {
    
    @StateObject private var firestoreWorldMsgModel = FirestoreWorldMsgModel()
    
    @State private var messageInput: String = ""
    
    var body: some View {
        
        
        
        TabView {
            
            
            VStack{
                Text("Lobby View")
                Button {
                    AppIndexManager.singletonObject.appIndex = AppIndex.onlineUsersView
                } label: {
                    Text("Online")
                }
                
                ScrollView{
                    
                    ForEach(firestoreWorldMsgModel.worldMessages) { worldMsg in
                        MessageView(user: worldMsg.username, message: worldMsg.message)
                    }

                        
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("gradient_black_20"))
                .cornerRadius(30)
                .padding()
                
                HStack {
                    TextField("Say something to the world...", text: $messageInput)
                        .padding()
                    Button {
                        sendMessage()
                    } label: {
                        Text("Send")
                            .padding()
                    }
                    .background(Color("gradient_black_40"))
                    .cornerRadius(30)

                }
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color("gradient_black_20"))
                .cornerRadius(30)
                .padding([.leading, .bottom, .trailing], 20)

            }
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
    
    private func sendMessage() {
        if messageInput.isEmpty {
            return
        }
        
        let currentUser = AppIndexManager.singletonObject.currentUser
        let newMessage = WorldMsgFirebase(_id: currentUser.id, _username: currentUser.username, _message: messageInput)
        
        firestoreWorldMsgModel.createMessage(newMessage: newMessage)
        
        messageInput = ""
    }

}

struct LobbyView_Previews: PreviewProvider {
    static var previews: some View {
        LobbyView( )
    }
}
