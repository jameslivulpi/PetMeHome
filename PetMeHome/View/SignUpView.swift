//
//  SignUpView.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/8/21.
//
//
//  SignInView.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/8/21.
//

import SwiftUI
import AuthenticationServices
import FirebaseFirestore

struct SignUpView: View {
    @EnvironmentObject var loginModel : LoginViewModel
  //  @StateObject var user : UserModel
    
    
    @State private var first_name = ""
    @State private var last_name = ""
    @State private var email = ""
    @State private var password = ""
    
        var body: some View {
            NavigationView{
            
            VStack {
                Text("Create your new account 👍🏼")
                               .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                               .font(.system(size: 30))
                               .font(.largeTitle)
                Spacer()
                Spacer()
            
                HStack{
                    Image(systemName: "person")
                    TextField("First Name", text: self.$first_name)
                            .padding()
                            .shadow(radius: 10)
                            .cornerRadius(5.0)
                            .padding(.bottom, 10)
                        
                } //end Hstack
                HStack {
                    Image(systemName: "person")
                    TextField("Last Name", text: self.$last_name)
                        .padding()
                        .shadow(radius: 10)
                        .cornerRadius(5.0)
                        .padding(.bottom, 10)
                }
                    
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
                            //  .background(Color(.secondarySystemBackground))
                        
                }
                    //NavigationLink(destination: SignedMenuView().navigationBarBackButtonHidden(true)) {
                Button(action: {
                    guard !email.isEmpty, !password.isEmpty else{
                        return
                    }
                    loginModel.signUp(email: email, password: password, firstname: first_name, lastname: last_name)
    
                    }, label: {
                        Text("Create Account")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(19)
                            .background(Color.blue)
                    })
    
                    .padding()
                Spacer()
            
            }
         //   .navigationTitle("Create Account")
                
            }
            //.padding()
        }
    
    
        
}
        

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
