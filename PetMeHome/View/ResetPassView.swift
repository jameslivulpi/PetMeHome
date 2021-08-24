//
//  ResetPassView.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/15/21.
//

import SwiftUI

struct ResetPassView: View {
    @EnvironmentObject var loginModel : LoginViewModel
    @State private var email = ""
    
    
    var body: some View {
        VStack{
            Text("Enter your email below to receive password reset instructions")
                .bold()
                .font(.caption2)
            
                
        
        HStack {
            
            Image(systemName:  "envelope")
            TextField("Email", text: self.$email)
                .padding()
                .border(Color.blue, width: 2)
             
                .shadow(radius: 10)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                
        }
        Button(action: {
            guard !email.isEmpty else{
                return
            }
            loginModel.forgotPass(email: self.email)

            }, label: {
                Text("Reset Password")
                    .padding()
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 50)
                    .cornerRadius(19)
                    .background(Color.blue)
            })
        
        }
        .navigationTitle("Forgot your Password?")
        
        
    }
}

struct ResetPassView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPassView()
    }
}
