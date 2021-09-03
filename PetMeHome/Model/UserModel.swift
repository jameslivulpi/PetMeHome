//
//  UserModel.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/21/21.
//

import Foundation

class UserModel: ObservableObject {
    @Published var user: User

    init(user: User = User(id: "", firstname: "", lastname: "", email: "")) {
        self.user = user
    }
}
