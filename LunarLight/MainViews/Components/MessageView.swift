//
//  MessageView.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-07.
//

import SwiftUI

struct MessageView: View {
    
    let user: String
    let message: String
    
    var body: some View {
        
        VStack {
            Divider()
                .padding(5)
                .opacity(0)
            
            HStack {
                Text("\(user): \(message)")
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(user: "Unknown", message: "Some message")
    }
}
