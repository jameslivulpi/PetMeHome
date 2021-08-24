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
    @Published var loginFail = false
    
    @Published var errorMsg = ""
    @Published var error = false
    @Published var registerUser = false
    @AppStorage("current_status") var status = false
    private var db = Firestore.firestore();
    
    @Published var isLoading = false
    
    func isSignedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password){ [weak self] result, error in
            if let error = error{
                self?.errorMsg = error.localizedDescription
                self?.loginFail = true
                return
            }
            
            DispatchQueue.main.async {
                self?.loginFail = false
                self?.signedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String, firstname: String, lastname: String){
        Auth.auth().createUser(withEmail: email, password: password){ [weak self] result, error in
            if error != nil{
                print(error!.localizedDescription)
            }else{
                self?.db.collection("users").addDocument(data: ["firstname": firstname, "lastname": lastname, "uid": result?.user.uid, "email": email]) { (error) in
                if error != nil {
                    print(error?.localizedDescription)
                }
            }
                            
                
            DispatchQueue.main.async {
                
                self?.signedIn = true
                
            }
        }
        }
    }
    
    func signOut(){
        try? Auth.auth().signOut()
        self.signedIn = false
    }
    
    func forgotPass(email: String){
        Auth.auth().sendPasswordReset(withEmail: email){ (error) in
            if error != nil{
                print(error!.localizedDescription)
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
