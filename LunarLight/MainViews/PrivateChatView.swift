//
//  PrivateChatView.swift
//  LunarLight
//
//  Created by Karol Öman on 2022-04-11.
//

import SwiftUI

struct PrivateChatView: View {
    
    @StateObject var firestorePrivateMsgModel = FirestorePrivateMsgModel()
    
    let friend: UserFirebase
    
    @State var newMessage = ""
    
    init() {
        friend = AppIndexManager.singletonObject.privateChatUser ?? AppIndexManager.singletonObject.testUser
    }
    
    var body: some View {
        VStack{
            Text(friend.username)
            
            HStack {
                Button {
                    AppIndexManager.singletonObject.appIndex = AppIndex.lobbyView
                } label: {
                    Text("Back")
                }
                Spacer()
            }
            ScrollView{
                Text("Message1")
                Text("Message2")
            }
            
            HStack {
                TextField("Message", text: $newMessage)
                Button {
                    newPrivateMsg()
                } label: {
                    Text("Send")
                }

            }
            
        }
    }
    
    func newPrivateMsg () {
        
        let newPrivateMsg = PrivateMsgFirebase(_message: newMessage)
        let currentUserId = AppIndexManager.singletonObject.currentUser.id
        let friendId = friend.id
        
        firestorePrivateMsgModel.createPrivateMsg(newPrivateMsg: newPrivateMsg, currentUserId: currentUserId, friendId: friendId)
        
    }
    
}

struct PrivateChatView_Previews: PreviewProvider {
    static var previews: some View {
        PrivateChatView()
    }
}
