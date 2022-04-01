//
//  ContentView.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-01.
//

import Foundation
import SwiftUI

struct ContentView: View {

    @ObservedObject var appIndexManager: AppIndexManager
    
    init() {
        appIndexManager = AppIndexManager.singletonObject
    }
    
    var body: some View {
        
        switch appIndexManager.appIndex {
        case AppIndex.welcomeView:
            WelcomeView()
        case AppIndex.registerQuestionsView:
            RegisterQuestionsView()
        }
        
    }
}


