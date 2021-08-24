//
//  MenuView.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/17/21.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var loginModel : LoginViewModel
    @State private var distance: Double = 5
    @State private var isEditing = false
    @ObservedObject var userSettings = UserSettings()
    var body: some View {
        VStack(alignment: .leading) {
          

            HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.gray)
                                .imageScale(.large)
                            Text("Messages")
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
                            .padding(.top, 100)
            Spacer()
            
            VStack{
                Text("Miles to show for missing animals")
                    .foregroundColor(.gray)
                    .font(.headline)
                
                Slider(value: $userSettings.milesToSearch, in: 0...100, step: 5, onEditingChanged: { editing in
                          isEditing = editing
                        }
                
                )
                
                
                .padding(.top, 30)
            
                  Text("\(userSettings.milesToSearch, specifier: "%.0f" ) Miles")
                      .foregroundColor(isEditing ? .red : .blue)
            }
            
            Spacer()
                        HStack {
                            Image(systemName: "person.fill.xmark")
                                .foregroundColor(.gray)
                                .imageScale(.large)
                            Button(action: {
                                loginModel.signOut()
                            }, label: {
                                Text("Logout")
                                    .foregroundColor(.gray)
                                    .font(.headline)
                            })
                            
                        }
                            .padding(.top, 30)
                            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)
            
        
            
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
