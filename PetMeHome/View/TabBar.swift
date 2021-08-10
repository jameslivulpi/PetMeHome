//
//  TabBar.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/8/21.
//

import SwiftUI

struct TabBar: View {
    @Binding var selected : String
    var body: some View {
        HStack(spacing: 65){
            TabButton(title: "test", selected: $selected)
            TabButton(title: "test2", selected: $selected)
        }
        .padding(.horizontal)
        .background(Color.white)
        .clipShape(Capsule())
    }
}

struct TabButton : View {
    var title: String
    @Binding var selected : String
    
    var body: some View{
        Button(action: {selected = title}){
            VStack(spacing: 5){
                Image(title)
                    .renderingMode(.template)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.bold)
            
            }
            .foregroundColor(selected == title ? Color("blue"): .gray)
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
    }
}

