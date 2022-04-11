//
//  LobbyChatView.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-01.
//

import SwiftUI

struct FriendsView: View {
    
    @StateObject var firestoreUserModel = FirestoreUserModel()
    @StateObject var chat = Chat()
    @State var showInfo : Bool = false
    
    let friends: [FriendFirebase]
    
    init() {
        friends = AppIndexManager.singletonObject.firestoreFriendModel.friends
    }
    
    var body: some View {
        
        VStack{
            NavigationView{
                List{
                    ForEach(firestoreUserModel.userFriends){ entry in
                        Button {
                            AppIndexManager.singletonObject.privateChatUser = entry
                            AppIndexManager.singletonObject.appIndex = AppIndex.privateChatView
                        } label: {
                            Text(entry.username)
                        }

                        //                        NavigationLink(destination: ChatView(entry: entry.user_id)){
                        //                            TitleRow(image: Image(systemName: entry.imageName), name: entry.name)
                        //                        }
                        //                        .onAppear(perform: { print(entry.date)})

                    }.onDelete(perform: { indexSet in
                        print ("delete")
                        chat.entries.remove(atOffsets: indexSet)
                    })
                }
            }
            Spacer()
        }.onAppear(){
            firestoreUserModel.listenToUserFriends()
        }
    }
}

struct LobbyChatView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
