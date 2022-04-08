//
//  MessageView.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-07.
//

import SwiftUI

struct MessageView: View {
    
    let user: String
    let message: String
    let avatar: String
    let month: UInt64
    let day: UInt64
    
    @State var backround: String
    
    init(_user: String, _message: String, _avatar: String, _month: UInt64, _day: UInt64){
    
        let localData = LocalData()
        user = _user
        message = _message
        avatar = _avatar
        month = _month
        day = _day
        let stoneIndex = UserFirebase.getStoneIndex(month: _month, day: _day)
        let stoneType = localData.profileBackground[stoneIndex]
        backround = stoneType
        
    }
    
    var body: some View {
        
        VStack {
            Divider()
                .padding(2)
                .opacity(0)
            
            HStack {
                
                Image(avatar)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(5)
                
                Text("\(user): \(message)")
                    .padding()
                    
            }
            .background(Color(backround))
                .cornerRadius(30)
            
            
            Divider()
                .padding(2)
                .opacity(0)
        }
    }
}
