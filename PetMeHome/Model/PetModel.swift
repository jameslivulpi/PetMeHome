//
//  Pet.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/7/21.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import CoreLocation
import Firebase
import GeoFire
import FirebaseCore
import FirebaseFirestore

struct Location: Identifiable {
    var id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}


class PetModel: ObservableObject {
    @Published var pet: Pet
    @Published var pets = [Pet]()
    @Published var annotations = [Location]()
    @Published var specieslist = ["Dog", "Cat"]
    
    var locationManager = LocationManager()
    var userSettings = UserSettings()
    private var db = Firestore.firestore();
    let uid = Auth.auth().currentUser!.uid
    
    init(pet: Pet = Pet(id: "", name: "", color: "", species: 0 , date: Date() , latitude: -1, longitude: -1, hash: "",  path : "")){
        self.pet = pet
    }
    
     func addPet(_ pet: Pet){
        do{
            print("ADDING \(pet)")
            //let _ = try db.collection("users").document(uid).collection("pets").document(pet.name).setData(from: pet)
            let _ = try db.collection("users").document("\(self.pet.id)").setData(from: pet)
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func listPets(){
        
  
        db.collection("users").addSnapshotListener{ (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No Pets!")
                return
            }
                
            self.pets = documents.map{ queryDocumentSnapshot -> Pet in
                let data = queryDocumentSnapshot.data()
                let id = data["id"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let color = data["color"] as? String ?? ""
                let species = data["species"] as? Int ?? -1
                let date = data["date"] as? Date ?? Date()
             //   let geo = data["geo"] as? GeoPoint ?? GeoPoint(latitude: 1, longitude: 1)
                let path = data["path"] as? String ?? ""
                let latitude = data["latitude"] as? Double ?? -1.0
                let longitude = data["longitude"] as? Double ?? -1.0
                let hash = data["hash"] as? String ?? ""
                    // let newAnnotation = [Location(name: name, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))]
                self.annotations.append(Location(name: name, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)))
                
            
            
               // self.geoQuery()
                
                
                
              //  print(Pet(id: id, name: name, color: color, species: species, date: date, latitude: latitude, longitude: longitude, hash: hash, path: path))
                return(Pet(id: id, name: name, color: color, species: species, date: date, latitude: latitude, longitude: longitude, hash: hash, path: path))
                
                
            }
                    
                    
            
        }
    }
    
    func geoQuery() {
            // [START fs_geo_query_hashes]
       
                                
            // Find cities within 50km of London
        let center = CLLocationCoordinate2D(latitude: locationManager.region.center.latitude, longitude: locationManager.region.center.longitude)

        //approx miles to meters
        let radiusInM: Double = userSettings.milesToSearch

            // Each item in 'bounds' represents a startAt/endAt pair. We have to issue
            // a separate query for each pair. There can be up to 9 pairs of bounds
            // depending on overlap, but in most cases there are 4.
            let queryBounds = GFUtils.queryBounds(forLocation: center,
                                                  withRadius: radiusInM)
            let queries = queryBounds.map { bound -> Query in
                return db.collection("users")
                    .order(by: "hash")
                    .start(at: [bound.startValue])
                    .end(at: [bound.endValue])
            }

          //  var matchingDocs = [Pet]()
            // Collect all the query results together into a single list
            func getDocumentsCompletion(snapshot: QuerySnapshot?, error: Error?) -> () {
                guard let documents = snapshot?.documents else {
                    print("Unable to fetch snapshot data. \(String(describing: error))")
                    return
                }

                for document in documents {
                    let lat = document.data()["latitude"] as? Double ?? 0
                    let lng = document.data()["longitude"] as? Double ?? 0
                    let coordinates = CLLocation(latitude: lat, longitude: lng)
                    let centerPoint = CLLocation(latitude: center.latitude, longitude: center.longitude)

                    // We have to filter out a few false positives due to GeoHash accuracy, but
                    // most will match
                    let distance = GFUtils.distance(from: centerPoint, to: coordinates)
                    if distance <= radiusInM {
                        
                        let id = document.data()["id"] as? String ?? ""
                        let name = document.data()["name"] as? String ?? ""
                        let color = document.data()["color"] as? String ?? ""
                        let species = document.data()["species"] as? Int ?? -1
                        let date = document.data()["date"] as? Date ?? Date()
                     //   let geo = data["geo"] as? GeoPoint ?? GeoPoint(latitude: 1, longitude: 1)
                        let path = document.data()["path"] as? String ?? ""
                        let latitude = document.data()["latitude"] as? Double ?? -1.0
                        let longitude = document.data()["longitude"] as? Double ?? -1.0
                        let hash = document.data()["hash"] as? String ?? ""
                        let pet = Pet(id: id, name: name, color: color, species: species, date: date, latitude: latitude, longitude: longitude, hash: hash, path: path)
                        pets.append(pet)
                        
                                               
                    }
                }
                
                
            }

            // After all callbacks have executed, matchingDocs contains the result. Note that this
            // sample does not demonstrate how to wait on all callbacks to complete.
            for query in queries {
                query.getDocuments(completion: getDocumentsCompletion)
                
            }
        
      //  self.pets = pets.map{ queryDocumentSnapshot -> Pet in
          //  let data = queryDocumentSnapshot.data()

        
        
           // self.geoQuery()
            
            
            
          //  print(Pet(id: id, name: name, color: color, species: species, date: date, latitude: latitude, longitude: longitude, hash: hash, path: path))
        //    return(Pet(id: pet.id, name: pet.name, color: pet.color, species: pet.species, date: pet.date, latitude: pet.latitude, longitude: pet.longitude, hash: pet.hash, path: pet.path))
        
    

    }
    
    func setPetImage(withImage: UIImage, andFileName: String) {
        guard let imageData = withImage.jpegData(compressionQuality: 0.0) else { return }
            let storageRef = Storage.storage().reference()
        let thisUserPhotoStorageRef = storageRef.child(andFileName)
            thisUserPhotoStorageRef.putData(imageData, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    print("error while uploading")
                    return
                }
            }
        }
    
    func getPetImages(){
        
    }


    
    
    func save(){
        addPet(self.pet)
    }
    
    
    
    
}

