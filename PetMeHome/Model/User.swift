//
//  UserModel.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/8/21.
//

import SwiftUI
import UIKit

struct User: Identifiable, Codable {
    var id: String
    var firstname: String
    var lastname: String
    var email: String
    // var username: String
    // var pic: String
//    var bio: String
}
