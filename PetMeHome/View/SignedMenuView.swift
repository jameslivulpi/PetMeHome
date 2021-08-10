//
//  SignedMenu.swift
//  petfinder
//
//  Created by James Livulpi on 8/5/21.
//

import SwiftUI

struct SignedMenuView: View {
    @EnvironmentObject var loginModel : LoginViewModel
    var body: some View {
        NavigationView {
        Form{
            Section{
                NavigationLink(destination: EnterLostPetView()) {
                    Button("Enter a lost pet"){}
                
                    }
                }
            Section{
                NavigationLink(destination: ListPetsView()) {
                    Button("View Lost Pets"){}
                }
            }
            Section{
                Button(action: {
                    loginModel.signOut()
                    
                    
           
                }, label: {
                    Text("Sign out")
                        .frame(width: 200, height: 50)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .padding()
                })
            }
    
        .animation(.easeIn)
        
        }
    
        }
    }
}
    



struct SignedMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SignedMenuView()
    }
}
