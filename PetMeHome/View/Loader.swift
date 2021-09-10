//
//  Loader.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/21/21.
//

import Combine
import FirebaseStorage
import Foundation
import SwiftUI

final class Loader: ObservableObject {
    @Published var data: Data?

    init(_ id: String) {
        // the path to the image
        let url = "\(id)"
        let storage = Storage.storage()
        let ref = storage.reference().child(url)

        ref.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if let error = error {
                print("\(error)")
            }
            print("fetching image")

            DispatchQueue.main.async {
                self.data = data
            }
        }
    }
}
