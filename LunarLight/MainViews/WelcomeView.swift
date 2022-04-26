//
//  RegisterQuestionsView.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-01.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    
    private var firestoreModel = FirestoreUserModel()
    
    let backgroundColor: String
    
    //Number of columns and column width
    let gridLayout = [
        GridItem(.flexible(minimum: UIScreen.main.bounds.width * 0.20)),
        GridItem(.flexible(minimum: UIScreen.main.bounds.width * 0.20)),
        GridItem(.flexible(minimum: UIScreen.main.bounds.width * 0.20)),
        GridItem(.flexible(minimum: UIScreen.main.bounds.width * 0.20))
    ]
    
    let profileImages: [String]
    @State var selectedImage: String
    
    @State var randomQuoteIndex = 0
    @State private var quotes = ["Carpe diem! /Sarah the great Philosopher"]
    
    init (){
        let localData = LocalData()
        var currentUser = AppManager.singletonObject.loggedInUser
        
        let stoneIndex = LocalData.getStoneIndex(month: currentUser.month, day: currentUser.day)
        let stoneType = localData.profileBackground[stoneIndex]
        
        backgroundColor = stoneType
        profileImages = localData.stoneImages[stoneType] ?? []
        selectedImage = profileImages[0]
        
        currentUser.avatar = profileImages[0]
        firestoreModel.updateUser(currentUser: currentUser)
        
        
    }
    
    var body: some View {
        

            
            //Background (first z-index)
            //Color(backgroundColor)
            
            //Foreground (second z-index)
            VStack{
                Text("Welcome")
                    .font(.title)
                    .padding(.bottom, 20)
                    .foregroundColor(.white)
                
                Text("Choose an icon that suits your soul:")
                    .font(Font.subheadline.weight(.bold))
                    .padding()
                    .foregroundColor(.white)
                
                LazyVGrid(columns: gridLayout, alignment: .center, content: {
                    ForEach(profileImages, id: \.self) { imageString in
                        Button {
                            updateAvatar(imageString)
                        } label: {
                            Image(imageString)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                            
                        }
                        .background(imageString == selectedImage ? Color(.white) : Color("gradient_white_30"))
                        .cornerRadius(65)
                    }
                })
                    .padding()
                
                Spacer()
                
                Text(quotes[randomQuoteIndex])
                    .foregroundColor(.white)
                    .font(Font.subheadline.weight(.bold))
                    .padding()
                    .frame(width: UIScreen.main.bounds.size.width * 0.8,
                           height: UIScreen.main.bounds.size.height * 0.2)
                    .background(Color("gradient_black_20"))
                    .cornerRadius(30)
                    .padding()
                    .task {
                        do {
                            let url = URL(string: "https://www.hackingwithswift.com/samples/quotes.txt")!
                            
                            for try await quote in url.lines {
                                quotes.append(quote)
                            }
                            randomQuoteIndex = Int.random(in: 0..<quotes.count)
                        } catch {
                            // Stop adding quotes when an error is thrown
                        }
                    }
                
                Spacer()
                
                Button {
                    AppManager.singletonObject.appIndex = AppIndex.lobbyView
                } label: {
                    Text("Enter the world of Lunar Light")
                        .font(Font.subheadline.weight(.bold))
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color("gradient_black_20"))
                        .cornerRadius(30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                
            }.padding()
                .background(Image("star_bg_sky")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea())
                .background(AppManager.singletonObject.personalGradientBGColor)
        

        
    }
    
    //Stores the new selected avatar image in Firestore, CoreData, and singleton-variable
    private func updateAvatar(_ imageString: String) {
        selectedImage = imageString
        
        AppManager.singletonObject.loggedInUser.avatar = imageString
        
        let currentUser = AppManager.singletonObject.loggedInUser
        
        let firestoreUserModel = FirestoreUserModel()
        firestoreUserModel.updateUser(currentUser: currentUser)
        
        let coredataUserModel = CoredataUserModel()
        AppManager.singletonObject.coreDataUser!.avatar = imageString
        coredataUserModel.updateUser()
        
        AppManager.singletonObject.profileUser = currentUser
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
