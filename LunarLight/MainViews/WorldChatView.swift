//
//  WorldChatView.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-07.
//

import SwiftUI

struct WorldChatView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \UserCoreData.username, ascending: true)],
        animation: .default)
    private var users: FetchedResults<UserCoreData>
    
    @StateObject private var firestoreWorldMsgModel = FirestoreWorldMsgModel()
    
    @State private var messageInput: String = ""
    
    var body: some View {
        VStack{
            
            HStack {
                Spacer()
                
                Button {
                    AppIndexManager.singletonObject.appIndex = AppIndex.onlineUsersView
                    
                } label: {
                    Text("Show Users")
                }.padding()
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.size.width * 0.45)
                
                    Spacer()
                
                Divider()
                    .frame(height: UIScreen.main.bounds.size.height * 0.05)
                    .background(.white)
                
                
                    Spacer()
                
                Button {
                    let coredataUserModel = CoredataUserModel()
                    for user in users {
                        coredataUserModel.deleteUser(user: user)
                    }
                    
                    AppIndexManager.singletonObject.logout()
                } label: {
                    Text("Logout")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.size.width * 0.45)
                }
                
                    Spacer()
            }
            Divider()
                .frame(width: UIScreen.main.bounds.size.width * 0.9)
                .background(.white)
            
            ScrollViewReader{ proxy in
            ScrollView{
                Divider()
                    .padding(2)
                    .opacity(0)
                
                ForEach(Array(firestoreWorldMsgModel.worldMessages.enumerated()), id: \.1) { index, worldMsg in
                    MessageView(_username: worldMsg.username, _message: worldMsg.message, _avatar: worldMsg.avatar, _month: worldMsg.month, _day: worldMsg.day, _isPrivate: false )
                        .id(index)
                }
                .onChange(of: firestoreWorldMsgModel.worldMessages, perform: { newValue in
                    print("*BLIPP*")
                    SoundPlayer.playSound(sound: SoundPlayer.NEW_MSG_SFX)
                })
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("gradient_white_10"))
            .cornerRadius(30)
            .padding()
            .onAppear {
                           proxy.scrollTo(firestoreWorldMsgModel.worldMessages.count - 1, anchor: .bottom)
                       }
            .onChange(of: firestoreWorldMsgModel.worldMessages.count, perform: { value in
                            proxy.scrollTo(firestoreWorldMsgModel.worldMessages.count - 1)
                            
                        })
        }
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
            .background(Color("gradient_white_10"))
            .cornerRadius(30)
            .padding()
            
        }.background(Image("star_bg_sky")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea())
            .background(AppIndexManager.singletonObject.personalGradientBGColor)
            
        .onAppear(perform: {
            firestoreWorldMsgModel.listenToWorldMessages()
        })
    }
    
    private func sendMessage() {
        if messageInput.isEmpty {
            return
        }
        
        print(messageInput)
        
        let currentUser = AppIndexManager.singletonObject.loggedInUser
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
