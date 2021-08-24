//
//  Pet.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/7/21.
//

import Foundation

import Firebase
import GeoFire
import FirebaseFirestoreSwift



struct Pet: Identifiable, Codable {
    var id: String
    var name: String
    var color: String
    var species: Int
    var date: Date
    var latitude: Double
    var longitude: Double
    var hash: String
    var path: String
}


enum Species: String, CaseIterable {
    case DOG
    case CAT
}
