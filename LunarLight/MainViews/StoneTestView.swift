//
//  StoneTestView.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-07.
//

import SwiftUI

struct StoneTestView: View {
    
    let backgroundColor: String
    
    init() {
        let localData = LocalData()
        
        let currentUser = AppIndexManager.singletonObject.currentUser
        let backgroundColorIndex = UserFirebase.getStoneIndex(from: currentUser)
        backgroundColor = localData.profileBackground[backgroundColorIndex]
        
        let stoneArray = localData.stoneImages[backgroundColor] ?? [""]
        

    }
    
    var body: some View {
        
        ZStack {
            
            //background
            Color(backgroundColor)
            
            //foreground
            VStack {
                Text("Stone Test View")
            }
        }.ignoresSafeArea()
    }
}

struct StoneTestView_Previews: PreviewProvider {
    static var previews: some View {
        StoneTestView()
    }
}
