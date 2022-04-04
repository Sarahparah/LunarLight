//
//  TitleRow.swift
//  LunarLight
//
//  Created by Sarah Lidberg on 2022-04-04.
//

import SwiftUI

struct TitleRow: View {
    
    var image = Image(systemName: "person")
    var name = "Sarah Sarahsson"
    var body: some View {
        HStack{
            image
                .resizable()
                .cornerRadius(50)
        }
        
    }
}

struct TitleRow_Previews: PreviewProvider {
    static var previews: some View {
        TitleRow()
    }
}
