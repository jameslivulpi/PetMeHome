//
//  MainMenu.swift
//  petfinder
//
//  Created by James Livulpi on 8/4/21.
//

import SwiftUI
import AuthenticationServices
import FirebaseFirestore

struct MainMenuView: View {
    @EnvironmentObject var loginModel : LoginViewModel
    
    private var db = Firestore.firestore()
   
    
        var body: some View {
            NavigationView {
                if loginModel.signedIn{
                    
                    //SignedMenuView()
                    
                    TabSetView()
                    
                    Button(action: {
                        loginModel.signOut()
                    }, label: {
                        Text("Sign Out")
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    })
                }else{
                    SignInView()
                }
            }
            .onAppear{
                loginModel.signedIn = loginModel.isSignedIn()
            }
        }
           
    
}



struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
            .preferredColorScheme(.dark)
    }
}
