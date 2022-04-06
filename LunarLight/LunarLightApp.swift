//
//  LunarLightApp.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-03-31.
//

import SwiftUI
import Firebase
@main
struct LunarLightApp: App {
    let persistenceController = PersistenceController.shared

    
    init(){
        FirebaseApp.configure()
        
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
