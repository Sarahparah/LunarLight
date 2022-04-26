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
    
    var body: some View {
        
        VStack{
            Text("Friends")
                .foregroundColor(.white)
                .font(.title)
                
            //NavigationView{
            ScrollView{
                    ForEach(firestoreUserModel.userFriends){ friend in
                        Button {
                            AppManager.singletonObject.privateChatUser = friend
                            AppManager.singletonObject.appIndex = AppIndex.privateChatView
                        } label: {
                            VStack{
                                HStack{
                                    Text(friend.username)
                                .foregroundColor(.white)
                                .padding(.trailing, 10)
                            Spacer()
                                }
                                
                                Divider()
                                    .frame(width: UIScreen.main.bounds.size.width * 0.8)
                                    .background(.white)
                        }
                            .padding([.trailing, .leading, .top], 10)
                    }
                    }
                
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("gradient_white_10"))
                .cornerRadius(30)
                .padding()
                
            //}
            Spacer()
        }
        .background(Image("star_bg_sky")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea())
        .background(AppManager.singletonObject.personalGradientBGColor)
            
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
