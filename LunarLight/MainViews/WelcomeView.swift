//
//  RegisterQuestionsView.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-01.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    
    let layout = [
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100))
    ]
    
    let profileImages: [String]
    @State var selectedImage: String
    
    init (){
        let localData = LocalData()
        profileImages = localData.profileImages
        selectedImage = profileImages[0]
        print("Selected image: \(selectedImage)")
    }
    
    var body: some View {
        
        VStack{
            Text("Welcome")
                .font(.title)
            
            ScrollView(.vertical){
                LazyVGrid(columns: layout, content: {
                    ForEach(profileImages, id: \.self) { imageString in
                        Button {
                            updateAvatar(imageString)
                        } label: {
                            Image(imageString)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                            
                        }
                        //.frame(width: 100, height: 100)
                        .background(imageString == selectedImage ? Color.green : Color.white)
                        .cornerRadius(65)
                    }
                })
            }.frame(height: UIScreen.main.bounds.height * 0.4)

            Spacer()
            
            Text("Some welcome info message... I dunno?")
            
            Spacer()
            
            Button {
                AppIndexManager.singletonObject.appIndex = AppIndex.lobbyView
            } label: {
                Text("Enter the world of Lunar Light")
            }

        }.padding()
    }
    
    private func updateAvatar(_ imageString: String) {
        selectedImage = imageString
        
        var currentUser = AppIndexManager.singletonObject.currentUser
        currentUser.avatar = imageString
        
        let firestoreUserModel = FirestoreUserModel()
        firestoreUserModel.updateUser(currentUser: currentUser)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
