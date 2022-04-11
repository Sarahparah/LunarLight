//
//  PrivateChatView.swift
//  LunarLight
//
//  Created by Karol Öman on 2022-04-11.
//

import SwiftUI

struct PrivateChatView: View {
    
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
                    AppIndexManager.singletonObject.appIndex = AppIndex.friendsView
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
                    print(newMessage)
                } label: {
                    Text("Send")
                }

            }
            
        }
    }
}

struct PrivateChatView_Previews: PreviewProvider {
    static var previews: some View {
        PrivateChatView()
    }
}
