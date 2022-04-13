//
//  WorldChatView.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-07.
//

import SwiftUI

struct WorldChatView: View {
    
    @StateObject private var firestoreWorldMsgModel = FirestoreWorldMsgModel()
    
    @State private var messageInput: String = ""
    
    var body: some View {
        VStack{
            
            HStack(alignment: .center){
                
                Button {
                    AppIndexManager.singletonObject.appIndex = AppIndex.onlineUsersView
                } label: {
                    Text("Show Users")
                }.padding()
                    .foregroundColor(.black)
                
                Divider()
                    .frame(height: UIScreen.main.bounds.size.height * 0.03)
                
                Button {
                    print("lobbies pressed - not in use")
                } label: {
                    Text("Choose Lobby")
                }.padding()
                    .foregroundColor(.black)
                
            }
            
            ScrollView{
                Divider()
                    .padding(2)
                    .opacity(0)
                
                ForEach(firestoreWorldMsgModel.worldMessages) { worldMsg in
                    MessageView(_username: worldMsg.username, _message: worldMsg.message, _avatar: worldMsg.avatar, _month: worldMsg.month, _day: worldMsg.day, _isPrivate: false )
                }
                .onChange(of: firestoreWorldMsgModel.worldMessages, perform: { newValue in
                    print("*BLIPP*")
                    SoundPlayer.playSound(sound: SoundPlayer.NEW_MSG_SFX)
                })
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("gradient_black_20"))
            .cornerRadius(30)
            .padding()
            
            HStack {
                TextField("Enter message..", text: $messageInput)
                    .foregroundColor(.white)
                    .accentColor(.white)
                    .padding()
                
                
                Button {
                    sendMessage()
                } label: {
                    Text("Send")
                        .padding()
                }
                .font(Font.subheadline.weight(.bold))
                .foregroundColor(Color.white)
                .padding(2)
                .background(Color("gradient_black_20"))
                .cornerRadius(30)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white, lineWidth: 1)
                )
                
            }
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(Color("gradient_black_20"))
            .cornerRadius(30)
            .padding()
            
        }
        .onAppear(perform: {
            firestoreWorldMsgModel.listenToWorldMessages()
        })
    }
    
    private func sendMessage() {
        if messageInput.isEmpty {
            return
        }
        
        print(messageInput)
        
        let currentUser = AppIndexManager.singletonObject.currentUser
        let newMessage = WorldMsgFirebase(_userId: currentUser.id, _username: currentUser.username, _message: messageInput, _avatar: currentUser.avatar, _month: currentUser.month, _day: currentUser.day)
        
        firestoreWorldMsgModel.createMessage(newMessage: newMessage)
        
        messageInput = ""
    }
}

struct WorldChatView_Previews: PreviewProvider {
    static var previews: some View {
        WorldChatView()
    }
}
