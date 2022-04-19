//
//  CoredataUserModel.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-13.
//

import Foundation

class CoredataUserModel {
    
    func createUser(currentUser: UserFirebase) {
     
        let viewContext = PersistenceController.shared.container.viewContext
        
        let userCoreData = UserCoreData(context: viewContext)
        userCoreData.id = currentUser.id
        userCoreData.username = currentUser.username
        userCoreData.email = currentUser.email
        userCoreData.password = currentUser.password
        userCoreData.year = Int64(currentUser.year)
        userCoreData.month = Int64(currentUser.month)
        userCoreData.day = Int64(currentUser.day)
        userCoreData.avatar = currentUser.avatar
        userCoreData.profile_info = currentUser.profile_info
        
        
        
        
        do {
            try viewContext.save()
            AppIndexManager.singletonObject.coreDataUser = userCoreData
            print("Du är inloggad: \(userCoreData)")
        } catch {
            print("Failed to save CoreData user")
        }
        
    }
    //kör en viewContext save som gör att databasen uppdateras
    func updateUser(){
        
        let viewContext = PersistenceController.shared.container.viewContext
        
        do{
            try viewContext.save()
            print("KOLLA OM DET SPARAS:  \(AppIndexManager.singletonObject.coreDataUser?.profile_info)")
            
        }catch{
            print("Failed to update user")
            
        }
              
    }
    
    func deleteUser(user: UserCoreData) {
        
        let viewContext = PersistenceController.shared.container.viewContext
        
        viewContext.delete(user)

        do {
            try viewContext.save()
        } catch {
            print("Failed to delete CoreData users")
        }
    }
    
    
    
    func updateUser(user: UserCoreData){

        let viewContext = PersistenceController.shared.container.viewContext

        do {
            try viewContext.save()
        } catch {
            print("Failed to save your profile info")
        }
    }
    
}
