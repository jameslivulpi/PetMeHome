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
    let didChange = PassthroughSubject<Data?, Never>()
    var data: Data? {
        didSet { didChange.send(data) }
    }

    init(_ id: String) {
        // the path to the image
        let url = "\(id)"
        let storage = Storage.storage(url: "gs://default-bucket/")
        let ref = storage.reference().child(url)
        ref.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if let error = error {
                print("\(error)")
            }

            DispatchQueue.main.async {
                self.data = data
            }
        }
    }
}
