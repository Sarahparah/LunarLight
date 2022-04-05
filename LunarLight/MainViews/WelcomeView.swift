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
    
    @State var selectedImage = ""
    
    init (){
        selectedImage = profileImages[0]
    }
    
    var body: some View {
        
        VStack{
            Text("Welcome")
                .font(.title)
            
            HStack {
                ForEach(profileImages, id: \.self) { imageString in
                    Button {
                        selectedImage = imageString
                    } label: {
                        Image(imageString)
                    }.background(imageString == selectedImage ? Color.red : Color.white)
                }
            }.frame(width: UIScreen.main.bounds.width * 1.0)
            Spacer()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
