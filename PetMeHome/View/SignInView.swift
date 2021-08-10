//
//  SignInView.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/8/21.
//

import SwiftUI
import AuthenticationServices
import FirebaseFirestore

struct SignInView: View {
    @EnvironmentObject var loginModel : LoginViewModel
    
    @State private var first_name = ""
    @State private var last_name = ""
    @State private var email = ""
    @State private var password = ""
    private var db = Firestore.firestore()
   
    
        var body: some View {
            NavigationView{
                VStack {
                    Image("mainmenu")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipped()
                        .cornerRadius(150)
                        .padding(.bottom)
                    
                    HStack {
                        Image(systemName:  "envelope")
                        TextField("Email", text: self.$email)
                            .padding()
                            .shadow(radius: 10)
                            .cornerRadius(5.0)
                            .padding(.bottom, 20)
                    }
                    
                    HStack{
                        Image(systemName: "key")
                        SecureField("password", text: $password)
                            .padding()
                    }
                    
                    
                    //NavigationLink(destination: SignedMenuView().navigationBarBackButtonHidden(true)) {
                
                    Button(action: {
                        guard !email.isEmpty, !password.isEmpty else{
                            return
                        }
                        loginModel.signIn(email: email, password: password)
                        
                    }, label: {
                        Text("Sign In")
                            .padding()
                            .frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .font(.headline)
                            .foregroundColor(.white)
                            .shadow(radius: 10)
                            .background(Color.blue)
                            .cornerRadius(15.0)
                            .padding()
                    })
                
                    //.foregroundColor(.white)
                    Spacer()
                    
                    NavigationLink("Create Account", destination: SignUpView())
                        .padding()
                       // .font(.headline)
                        .foregroundColor(.black)
                        .shadow(radius: 10)
                        .background(Color.white)
                        .cornerRadius(15.0)
                        //.padding(.bottom)
                    
                }
                    .padding()
                    Spacer()
                
                
                
                
            }
            //.navigationTitle("Sign In")

            
        }

            
}
        

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
