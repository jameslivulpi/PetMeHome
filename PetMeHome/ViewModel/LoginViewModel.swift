//
//  SwiftUIView.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/8/21.
//

import SwiftUI
import Firebase


class LoginViewModel : ObservableObject {
    @Published var code = ""
    @Published var number = ""
    @Published var signedIn = false
    
    @Published var errorMsg = ""
    @Published var error = false
    @Published var registerUser = false
    @AppStorage("current_status") var status = false
    
    @Published var isLoading = false
    
    func isSignedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password){ [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password){ [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
                
            }
        }
    }
    
    func signOut(){
        try? Auth.auth().signOut()
        self.signedIn = false
    }
    
    
    func verify(){
        isLoading = true
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        let phoneNumber = "+" + code + number
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (ID, err) in
            if err != nil {
                self.errorMsg = err!.localizedDescription
                self.error.toggle()
                self.isLoading = false
                return
                
            }
            
            alertView(msg: "Enter auth code"){ (code) in
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: ID!, verificationCode: code)
                
                Auth.auth().signIn(with: credential) { (res, err) in
                    if err != nil {
                        self.errorMsg = err!.localizedDescription
                        self.error.toggle()
                        self.isLoading = false
                        return
                        
                    }
                    self.checkUser()
                }
                
                
            }
        }
    }
    
    func checkUser(){
        let ref = Firestore.firestore()
        let uid = Auth.auth().currentUser!.uid
        
        ref.collection("Users").whereField("uid" ,isEqualTo: uid).getDocuments{ (snap, err) in
            if err != nil {
                self.registerUser.toggle()
                self.isLoading = false
                return
                
            }
            
            if snap!.documents.isEmpty {
                self.registerUser.toggle()
                self.isLoading = false
                return
            }
            self.status = true
        }
    }
}
