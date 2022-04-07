//
//  User.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-06.
//

import Foundation
import FirebaseFirestoreSwift

struct UserFirebase: Codable, Identifiable{
    
    var id: String
    var username: String
    var email: String
    var password: String
    var year: UInt64
    var month: UInt64
    var day: UInt64
    var avatar: String
    
    init(_id: String = "", _username: String, _email: String, _password: String, _year: UInt64, _month: UInt64, _day: UInt64, _avatar: String ){
        
        id = _id
        username = _username
        email = _email
        password = _password
        year = _year
        month = _month
        day = _day
        avatar = _avatar
    }
    
    func getStoneName() -> String {
        
        let localData = LocalData()
        let stones = localData.stoneArray
        
        switch month {
        case 1:
            if day >= 1 && day <= 20 {
                return stones[0]
            }
            else {
                return stones[1]
            }
        case 2:
            if day >= 1 && day <= 18 {
                return stones[1]
            }
            else {
                return stones[2]
            }
        case 3:
            if day >= 1 && day <= 19 {
                return stones[2]
            }
            else {
                return stones[3]
            }
        case 4:
            if day >= 1 && day <= 19 {
                return stones[3]
            }
            else {
                return stones[4]
            }
        case 5:
            if day >= 1 && day <= 20 {
                return stones[4]
            }
            else {
                return stones[5]
            }
        case 6:
            if day >= 1 && day <= 20 {
                return stones[5]
            }
            else {
                return stones[6]
            }
        case 7:
            if day >= 1 && day <= 22 {
                return stones[6]
            }
            else {
                return stones[7]
            }
        case 8:
            if day >= 1 && day <= 22 {
                return stones[7]
            }
            else {
                return stones[8]
            }
        case 9:
            if day >= 1 && day <= 22 {
                return stones[8]
            }
            else {
                return stones[9]
            }
        case 10:
            if day >= 1 && day <= 22 {
                return stones[9]
            }
            else {
                return stones[10]
            }
        case 11:
            if day >= 1 && day <= 22 {
                return stones[10]
            }
            else {
                return stones[11]
            }
        case 12:
            if day >= 1 && day <= 21 {
                return stones[11]
            }
            else {
                return stones[0]
            }
            
        default:
            //Fallback (default stone)
            print("Error: Could not find correct stone (default was choosen)")
            return stones[0]
        }
    }
    
}
