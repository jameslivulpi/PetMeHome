//
//  FirebaseImage.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/21/21.
//

import SwiftUI
import UIKit
import FirebaseStorage
import Combine
import Firebase


let placeholder = UIImage(named: "dog-placeholder")!


struct FirebaseImage : View {

    init(id: String) {
        self.imageLoader = Loader(id)
    }

    @ObservedObject private var imageLoader : Loader

    var image: UIImage? {
        imageLoader.data.flatMap(UIImage.init)
    }

    var body: some View {
        Image(uiImage: image ?? placeholder)
            .resizable()
            .scaledToFit()

    }
}

