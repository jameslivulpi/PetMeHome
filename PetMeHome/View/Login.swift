//
//  Login.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/8/21.
//

import SwiftUI

struct Login: View {
    @StateObject var loginData = LoginViewModel()
    
    
    var body: some View {
        VStack{
            HStack{
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }
            .padding()
            
            HStack(spacing: 15){
                TextField("1", text: $loginData.code)
                    .padding()
                    .keyboardType(.numberPad)
                    .frame(width: 45)
                    .background(Color.white.opacity(0.06))
                    .cornerRadius(15)
                TextField("1234567890", text: $loginData.code)
                    .padding()
                    .keyboardType(.numberPad)
                    .frame(width: 45)
                    .background(Color.white.opacity(0.06))
                    .cornerRadius(15)
            }
            .padding()
            .padding(.top,10)
            
            if self.loginData.isLoading{
            
               // ProgresssView()
               //     .padding()
            
            }
            else{
                Button(action: self.loginData.verify, label: {
                    Text("Register")
                        .foregroundColor(.white)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                        .background(Color("blue"))
                        .clipShape(Capsule())
                    
                })
                .disabled(loginData.code == "" || loginData.number == "" ? true : false)
                .opacity(loginData.code == "" || loginData.number == "" ? 0.5 : 1)
            }
            Spacer(minLength: 0)
        }
       
        
        .alert(isPresented: $loginData.error, content: {
            Alert(title: Text("Error"), message: Text(loginData.errorMsg), dismissButton: .destructive(Text("OK")))
        })
        .fullScreenCover(isPresented: $loginData.registerUser, content: {
            Register()
        })
    }
}
        


struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
