//
//  TitleRow.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-04.
//

import SwiftUI

struct TitleRow: View {
    
    var image: Image
    var name: String
    
    
    var body: some View {
        
        HStack{
            image
                .resizable()
                .frame( width: UIScreen.main.bounds.size.height * 0.05, height: UIScreen.main.bounds.size.height * 0.05)
                .scaledToFill()
                .cornerRadius(20)
        }
        
        VStack(alignment: .leading){
            Text(name)
                .font(.title).bold()
            Text("Online")
                .foregroundColor(.purple)
                .font(.caption)
        }
    }
}

struct TitleRow_Previews: PreviewProvider {
    static var previews: some View {
        TitleRow(image: Image(systemName: "person"), name: "Sarah")
    }
}
