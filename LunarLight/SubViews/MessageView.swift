//
//  MessageView.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-07.
//

import SwiftUI

struct MessageView: View {
    
    let username: String
    let message: String
    let avatar: String
    let month: UInt64
    let day: UInt64
    
    let msgPrefix: String
    
    @State var backround: String
    
    init(_username: String, _message: String, _avatar: String, _month: UInt64, _day: UInt64, _isPrivate: Bool){
        
        let localData = LocalData()
        username = _username
        message = _message
        avatar = _avatar
        month = _month
        day = _day
        let stoneIndex = UserFirebase.getStoneIndex(month: _month, day: _day)
        let stoneType = localData.profileBackground[stoneIndex]
        backround = stoneType
        
        if _isPrivate {
            msgPrefix = ""
        }
        else {
            msgPrefix = username + ": "
        }
        
    }
    
    var body: some View {
        
        VStack(alignment: AppIndexManager.singletonObject.currentUser.username == username ? .trailing : .leading) {
            
            HStack{
                
                HStack(alignment:.top) {
                    
                    Image(avatar)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .background(.white)
                        .cornerRadius(30)
                        .padding(8)
                    
                    Text("\(msgPrefix)\(message)")
                        .padding([.top, .bottom], 20)
                        .padding(.trailing, 30)
                    
                    //Spacer()
                }
                //.frame(width: UIScreen.main.bounds.size.width * 0.7)
                .background(Color(backround))
                .cornerRadius(30)
                .padding(5)
                
                //Spacer()
            }
            .frame(maxWidth: 300, alignment: AppIndexManager.singletonObject.currentUser.username == username ? .trailing : .leading)
            
        }
        .frame(maxWidth: .infinity, alignment: AppIndexManager.singletonObject.currentUser.username == username ? .trailing : .leading)
        //.padding(AppIndexManager.singletonObject.currentUser.username == user ? .trailing : .leading)
    }
}
