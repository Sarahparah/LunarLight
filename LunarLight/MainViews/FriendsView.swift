//
//  LobbyChatView.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-01.
//

import SwiftUI

struct FriendsView: View {
    
    @StateObject var firestoreUserModel = FirestoreUserModel()
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

                    }
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
