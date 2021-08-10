//
//  Pet.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/7/21.
//

import Foundation
import FirebaseFirestore

class PetModel: ObservableObject {
    @Published var pet: Pet
    @Published var pets = [Pet]()
    @Published var specieslist = ["Dog", "Cat"]
    
    private var db = Firestore.firestore()
    
    init(pet: Pet = Pet(id: UUID(), name: "", color: "", species: 0 , date: Date() , geo: GeoPoint(latitude: 1, longitude: 1))) {
        self.pet = pet
       
        
    }
    
     func addPet(_ pet: Pet){
        do{
            let _ = try db.collection("users").document("\(pet.id)").setData(from: pet)
        
        }
        catch{
            print(error)
        }
    }
    
    func listPets(){
        db.collection("users").getDocuments(){ (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No Pets!")
                return
            }
                
            self.pets = documents.map{ queryDocumentSnapshot -> Pet in
                let data = queryDocumentSnapshot.data()
                let id = data["id"] as? UUID ?? UUID()
                let name = data["name"] as? String ?? ""
                let color = data["color"] as? String ?? ""
                let species = data["species"] as? Int ?? -1
                let date = data["date"] as? Date ?? Date()
                let geo = data["geo"] as? GeoPoint ?? GeoPoint(latitude: 1, longitude: 1)
                
             
                return(Pet(id: id, name: name, color: color, species: species, date: date, geo: geo))
                
                
            }
                    
                    
            
        }
    }
    
    func save(){
        addPet(self.pet)
    }
    
    
    
    
}

