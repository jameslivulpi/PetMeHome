//
//  RegisterViewModel.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/8/21.
//

import SwiftUI
import Firebase

class RegisterViewModel : ObservableObject{
    @Published var name = ""
    @Published var picker = false
    let ref = Firestore.firestore()
    
    @Published var image_data = Data(count: 0)
    
    @Published var isLoading = false
    @AppStorage("current_status") var status = false
    
    func register(){
        isLoading = true
        let uid = Auth.auth().currentUser?.uid
        
        UploadImage(imageData: image_data, path: "profile"){ (url) in
    
        
            self.ref.collection("Users").document(uid!).setData([
                "uid": uid ?? "",
                "dateCreated" : Date()
        ]) { (err) in
            if err != nil {
                self.isLoading = false
                return
            }
            self.isLoading = false
            self.status = true
        }
    }
}
}
    



