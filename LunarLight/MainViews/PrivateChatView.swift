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
    
    let userBackground: String
    let friendBackground: String
    
    @State var newMessage = ""
    
    init() {
        let localData = LocalData()
        
        currentUser = AppIndexManager.singletonObject.loggedInUser
        friend = AppIndexManager.singletonObject.privateChatUser ?? AppIndexManager.singletonObject.testUser
        
        let userStoneIndex = UserFirebase.getStoneIndex(month: currentUser.month, day: currentUser.day)
        let userStoneType = localData.profileBackground[userStoneIndex]
        
        userBackground = userStoneType
        
        let friendStoneIndex = UserFirebase.getStoneIndex(month: friend.month, day: friend.day)
        let friendStoneType = localData.profileBackground[friendStoneIndex]
        
        friendBackground = friendStoneType
    }
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(userBackground), Color(friendBackground)]), startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            
            VStack{
                Button {
                    firestoreUserModel.getProfileUser(profileId: friend.id)
                } label: {
                    Text(friend.username)
                        .foregroundColor(.white)
                }
                .sheet(isPresented: $firestoreUserModel.profileUserActive){
                    ProfileView(_user: firestoreUserModel.profileUser!)
                }

                
                HStack {
                    Button {
                        AppIndexManager.singletonObject.appIndex = AppIndex.lobbyView
                    } label: {
                        Text("< Back")
                            .foregroundColor(.white)
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
                            MessageView(_username: currentUser.username, _message: message.my_message, _avatar: currentUser.avatar, _month: currentUser.month, _day: currentUser.day, _isPrivate: true )
                        }
                        else{
                            MessageView(_username: friend.username, _message: message.my_message, _avatar: friend.avatar, _month: friend.month, _day: friend.day, _isPrivate: true )
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
                
            }.background(Image("star_bg_sky")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea())
                .onAppear(perform: {
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
    
    }
    
    func updateMessagesArray() {
        self.messages.removeAll()
        self.messages.append(contentsOf: firestorePrivateMsgModel.userMsgs)
        self.messages.append(contentsOf: firestorePrivateMsgModel.friendMsgs)
        self.messages = self.messages.sorted(by: { $0.timestamp < $1.timestamp })
    }
    
    func newPrivateMsg () {
        
        let currentUserId = AppIndexManager.singletonObject.loggedInUser.id
        let friendId = friend.id
        
        let newPrivateMsg = PrivateMsgFirebase(_message: newMessage, _senderId: currentUserId, _receiverId: friendId)
        newMessage = ""
        
        firestorePrivateMsgModel.createPrivateMsg(newPrivateMsg: newPrivateMsg, currentUserId: currentUserId, friendId: friendId)
        
    }
    
}

struct PrivateChatView_Previews: PreviewProvider {
    static var previews: some View {
        PrivateChatView()
    }
}
