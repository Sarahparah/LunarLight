//
//  RegisterQuestionsView.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-01.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    
    var profileImages = ["Bengan", "Sloomie", "ssssLord", "BillyClown", "kringiLord"]
    
    let layout = [
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100))
    ]
    
    @State var selectedImage = ""
    
    init (){
        selectedImage = profileImages[0]
    }
    
    var body: some View {
        
        VStack{
            Text("Welcome")
                .font(.title)
            
            ScrollView(.vertical){
                LazyVGrid(columns: layout, content: {
                    ForEach(profileImages, id: \.self) { imageString in
                        Button {
                            selectedImage = imageString
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
            }

            Spacer()
        }.padding()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
