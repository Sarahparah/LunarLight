//
//  PrivateChatView.swift
//  LunarLight
//
//  Created by Karol Öman on 2022-04-11.
//

import SwiftUI

struct PrivateChatView: View {
    
    @StateObject var firestorePrivateMsgModel = FirestorePrivateMsgModel()
    
    @StateObject var firestoreUserModel = FirestoreUserModel()
    
    @State var messages = [PrivateMsgFirebase]()
    
    let currentUser: UserFirebase
    let friend: UserFirebase
    
    @State var newMessage = ""
    
    init() {
        currentUser = AppIndexManager.singletonObject.currentUser
        friend = AppIndexManager.singletonObject.privateChatUser ?? AppIndexManager.singletonObject.testUser
    }
    
    var body: some View {
        VStack{
            Button {
                firestoreUserModel.getProfileUser(profileId: friend.id)
            } label: {
                Text(friend.username)
            }
            .sheet(isPresented: $firestoreUserModel.profileUserActive){
                ProfileView(_user: firestoreUserModel.profileUser!)
            }

            
            HStack {
                Button {
                    AppIndexManager.singletonObject.appIndex = AppIndex.lobbyView
                } label: {
                    Text("< Back")
                }
                .padding()
                
                Spacer()
            }
            
            ScrollView{
                
                Divider()
                    .padding(2)
                    .opacity(0)
                
                ForEach (messages) { message in
                    if message.sender_id == currentUser.id {
                        MessageView(_user: currentUser.username, _message: message.my_message, _avatar: currentUser.avatar, _month: currentUser.month, _day: currentUser.day )
                    }
                    else{
                        MessageView(_user: friend.username, _message: message.my_message, _avatar: friend.avatar, _month: friend.month, _day: friend.day )
                    }
                }
                .onChange(of: messages, perform: { newValue in
                    print("*BLIPP*")
                    SoundPlayer.playSound(sound: SoundPlayer.NEW_MSG_SFX)
                })
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("gradient_black_20"))
            .cornerRadius(30)
            .padding()
            
            HStack {
                TextField("Enter message..", text: $newMessage)
                    .foregroundColor(.white)
                    .accentColor(.white)
                    .padding()
                
                
                Button {
                    newPrivateMsg()
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
            
        }.onAppear(perform: {
            print("DANNE: 0, listen!")
            firestorePrivateMsgModel.listenToUserMsgs()
            firestorePrivateMsgModel.listenToFriendMsgs()
        })
            .onChange(of: firestorePrivateMsgModel.userMsgs, perform: {newValue in
                updateMessagesArray()
            })
            .onChange(of: firestorePrivateMsgModel.friendMsgs, perform: {newValue in
                updateMessagesArray()
            })
    }
    
    func updateMessagesArray() {
        self.messages.removeAll()
        self.messages.append(contentsOf: firestorePrivateMsgModel.userMsgs)
        self.messages.append(contentsOf: firestorePrivateMsgModel.friendMsgs)
        self.messages = self.messages.sorted(by: { $0.timestamp < $1.timestamp })
    }
    
    func newPrivateMsg () {
        
        let currentUserId = AppIndexManager.singletonObject.currentUser.id
        let friendId = friend.id
        
        let newPrivateMsg = PrivateMsgFirebase(_message: newMessage, _senderId: currentUserId)
        newMessage = ""
        
        firestorePrivateMsgModel.createPrivateMsg(newPrivateMsg: newPrivateMsg, currentUserId: currentUserId, friendId: friendId)
        
    }
    
}

struct PrivateChatView_Previews: PreviewProvider {
    static var previews: some View {
        PrivateChatView()
    }
}
