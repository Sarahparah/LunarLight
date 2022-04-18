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
            Text("Friends")
                .foregroundColor(.white)
                .font(.title)
                
            //NavigationView{
            ScrollView{
                    ForEach(firestoreUserModel.userFriends){ entry in
                        Button {
                            AppIndexManager.singletonObject.privateChatUser = entry
                            AppIndexManager.singletonObject.appIndex = AppIndex.privateChatView
                        } label: {
                            Text(entry.username)
                                .foregroundColor(.white)
                            Spacer()
                        }

                    }.padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("gradient_white_10"))
                .cornerRadius(30)
                .padding()
                
            //}
            Spacer()
        }
        .background(Image("star_heaven")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea())
        .background(AppIndexManager.singletonObject.personalGradientBGColor)
            
        .onAppear(){
            firestoreUserModel.listenToUserFriends()
        }
    }
}

struct LobbyChatView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
