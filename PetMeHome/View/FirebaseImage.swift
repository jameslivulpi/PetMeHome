//
//  FirebaseImage.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/21/21.
//

import Combine
import Firebase
import FirebaseStorage
import SwiftUI
import UIKit

let placeholder = UIImage(named: "dog-placeholder")!

struct FirebaseImage: View {
    init(id: String) {
        imageLoader = Loader(id)
    }

    @ObservedObject private var imageLoader: Loader

    var image: UIImage? {
        imageLoader.data.flatMap(UIImage.init)
    }

    var body: some View {
        Image(uiImage: image ?? placeholder)
            .resizable()
            .frame(width: 100, height: 100)
    }
}
