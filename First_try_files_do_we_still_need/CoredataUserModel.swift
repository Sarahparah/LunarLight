//
//  CoredataUserModel.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-01.
//

import Foundation
import CoreData

class CoredataUserModel {
    
    let viewContext: NSManagedObjectContext
    
    init() {
        viewContext = PersistenceController.shared.container.viewContext
        

    }
    
    func saveUser(username: String, password: String, dateOfBirth: Date, email: String) {
        
        print("Saving user...")
        
        
        
        var currentUserId = -1
        
        let preferences = UserDefaults.standard
        let currentUserIdKey = "currentUserId"
        if preferences.object(forKey: currentUserIdKey) == nil {
            print("Error: Could not find shared preferences key currentUserId")
            return
        } else {
            currentUserId = preferences.integer(forKey: currentUserIdKey)
        }
        
        
//        let user = User(context: viewContext)
//        user.id = Int16(currentUserId)
//        user.username = username
//        user.password = password
//        user.dateOfBirth = dateOfBirth
//        user.email = email

        do {
            try viewContext.save()
            
            preferences.set(currentUserId+1, forKey: currentUserIdKey)
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        
    }
    
}

