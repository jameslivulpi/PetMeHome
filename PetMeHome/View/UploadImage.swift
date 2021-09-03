//
//  UploadImage.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/8/21.
//

import Firebase
import FirebaseStorage
import SwiftUI

func UploadImage(imageData: Data, path: String, completion: @escaping (String) -> Void) {
    let storage = Storage.storage().reference()
    let uid = Auth.auth().currentUser!.uid

    storage.child(path).child(uid).putData(imageData, metadata: nil) { _, err in
        if err != nil {
            completion("")
            return
        }

        storage.child(path).child(uid).downloadURL { url, err in
            if err != nil {
                completion("")
                return
            }
            completion("\(url!)")
        }
    }
}
