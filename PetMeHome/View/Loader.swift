//
//  Loader.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/21/21.
//

import Foundation
import SwiftUI
import Combine
import FirebaseStorage

final class Loader : ObservableObject {
    let didChange = PassthroughSubject<Data?, Never>()
    var data: Data? = nil {
        didSet { didChange.send(data) }
    }
    


    init(_ id: String){
        // the path to the image
        let url = "\(id)"
        let storage = Storage.storage()
        let ref = storage.reference().child(url)
        ref.getData(maxSize: 3 * 1024 * 1024) { data, error in
            if let error = error {
                print("\(error)")
            }

            DispatchQueue.main.async() {
                self.data = data
            }
        }
    }
}
