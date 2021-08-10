//
//  Pet.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/7/21.
//

import Foundation

import Firebase
import FirebaseFirestoreSwift


struct Pet: Identifiable, Codable {
    var id: UUID
    var name: String
    var color: String
    var species: Int
    var date: Date
    var geo : GeoPoint
}


enum Species: String, CaseIterable {
    case DOG
    case CAT
}
