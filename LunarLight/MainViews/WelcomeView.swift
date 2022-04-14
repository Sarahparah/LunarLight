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
    
    let layout = [
        GridItem(.flexible(minimum: UIScreen.main.bounds.width * 0.2)),
        GridItem(.flexible(minimum: UIScreen.main.bounds.width * 0.2)),
        GridItem(.flexible(minimum: UIScreen.main.bounds.width * 0.2)),
        GridItem(.flexible(minimum: UIScreen.main.bounds.width * 0.2))
    ]
    
    let profileImages: [String]
    @State var selectedImage: String
    
    @State var randomQuoteIndex = 0
    @State private var quotes = ["temp Quote"]
    
    init (){
        let localData = LocalData()
        var currentUser = AppIndexManager.singletonObject.loggedInUser
        
        let stoneIndex = UserFirebase.getStoneIndex(month: currentUser.month, day: currentUser.day)
        let stoneType = localData.profileBackground[stoneIndex]
        
        backgroundColor = stoneType
        profileImages = localData.stoneImages[stoneType] ?? []
        selectedImage = profileImages[0]
        print("Selected image: \(selectedImage)")
        
        currentUser.avatar = profileImages[0]
        firestoreModel.updateUser(currentUser: currentUser)
        
        
    }
    
    var body: some View {
        
        ZStack {
            
            //Background (first z-index)
            //Color(backgroundColor)
            
            LinearGradient(gradient: Gradient(colors: [Color(backgroundColor), .black]), startPoint: .bottomTrailing, endPoint: .topLeading)
                .ignoresSafeArea()
            
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
                //                    .background(Color("gradient_black_20"))
                //                    .foregroundColor(Color.black)
                //                    .cornerRadius(30)
                //
                
                
                //ScrollView(.vertical){
                
                //}.frame(height: UIScreen.main.bounds.height * 0.4)
                
                LazyVGrid(columns: layout, alignment: .center, content: {
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
                    AppIndexManager.singletonObject.appIndex = AppIndex.lobbyView
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
                .background(Image("star_heaven")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea())
        

        }
    }
    
    private func updateAvatar(_ imageString: String) {
        selectedImage = imageString
        
        var currentUser = AppIndexManager.singletonObject.loggedInUser
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
