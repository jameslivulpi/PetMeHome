//
//  UserLocalSettings.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/21/21.
//

import Combine
import Foundation

class UserSettings: ObservableObject {
    init() {
        milesToSearch = UserDefaults.standard.object(forKey: "milesToSearch") as? Double ?? 5.0
    }

    @Published var milesToSearch: Double {
        didSet {
            UserDefaults.standard.set(milesToSearch, forKey: "milesToSearch")
        }
    }
}
