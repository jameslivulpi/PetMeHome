//
//  UserLocalSettings.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/21/21.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    
    init() {
        self.milesToSearch = UserDefaults.standard.object(forKey: "milesToSearch") as? Double ?? 5.0
       
    }
    
    
    @Published var milesToSearch: Double {
        didSet {
            UserDefaults.standard.set(milesToSearch, forKey: "milesToSearch")
        }
    }
}
    
   
