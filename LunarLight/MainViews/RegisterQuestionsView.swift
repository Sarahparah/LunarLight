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
            VStack{
             
                
                Text("We are so happy to welocome you too LunarLight's cumunity. First of all, we would like to answer a couple of questions.")
                Text(" What would you prefer?")
                
            }
                //.badge(10)
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("First")
                }
            VStack{
                
                Text("Another Tab")
            
            }
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Second")
                }
            VStack{
            
                Text("The Last Tab")
            
            }
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("Third")
                }
        }
        .font(.headline)
        
    }
}
