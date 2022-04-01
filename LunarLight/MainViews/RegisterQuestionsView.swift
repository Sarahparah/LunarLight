//
//  RegisterQuestionsView.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-01.
//

import Foundation
import SwiftUI

struct RegisterQuestionsView: View {
    
    var body: some View {
        
        //NAV BAR
        HStack{
            Button(action: {
                AppIndexManager.singletonObject.appIndex = AppIndex.welcomeView
            }, label: {
                Text("Back")
            }).padding()
            Spacer()
        }
        
        TabView {
            Text("The First Tab")
                //.badge(10)
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("First")
                }
            Text("Another Tab")
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Second")
                }
            Text("The Last Tab")
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("Third")
                }
        }
        .font(.headline)
        
    }
}
