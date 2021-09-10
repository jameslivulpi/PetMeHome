//
//  Pet.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/7/21.
//

import CoreLocation
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import Foundation
import GeoFire

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
    private var db = Firestore.firestore()
    let uid = Auth.auth().currentUser!.uid
    let dateformatter = DateFormatter()

    init(pet: Pet = Pet(id: "", name: "", color: "", species: 0, date: "", latitude: -1, longitude: -1, hash: "", path: "")) {
        self.pet = pet
    }

    func addPet(_ pet: Pet) {
        do {
            print("ADDING \(pet)")
            // let _ = try db.collection("users").document(uid).collection("pets").document(pet.name).setData(from: pet)
            _ = try db.collection("pets").document("\(self.pet.id)").setData(from: pet)
        } catch {
            print(error.localizedDescription)
        }
    }

    func listPets() {
        db.collection("pets").addSnapshotListener { querySnapshot, _ in
            guard let documents = querySnapshot?.documents else {
                print("No Pets!")
                return
            }

            self.pets = documents.map { queryDocumentSnapshot -> Pet in
                let data = queryDocumentSnapshot.data()
                let id = data["id"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let color = data["color"] as? String ?? ""
                let species = data["species"] as? Int ?? -1
                let date = data["date"] as? String ?? ""
                //   let geo = data["geo"] as? GeoPoint ?? GeoPoint(latitude: 1, longitude: 1)
                let path = data["path"] as? String ?? ""
                let latitude = data["latitude"] as? Double ?? -1.0
                let longitude = data["longitude"] as? Double ?? -1.0
                let hash = data["hash"] as? String ?? ""
                // let newAnnotation = [Location(name: name, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))]
                self.annotations.append(Location(name: name, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)))

                self.geoQuery()

                //  print(Pet(id: id, name: name, color: color, species: species, date: date, latitude: latitude, longitude: longitude, hash: hash, path: path))
                return (Pet(id: id, name: name, color: color, species: species, date: date, latitude: latitude, longitude: longitude, hash: hash, path: path))
            }
        }
    }

    func geoQuery() {
        // [START fs_geo_query_hashes]

        // get location of user
        let center = CLLocationCoordinate2D(latitude: locationManager.region.center.latitude, longitude: locationManager.region.center.longitude)

        // convert user setting of how many miles around them to look
        // miles to meters is 1 miles == 1609.34 meters
        let radiusInM: Double = userSettings.milesToSearch * 1609.34

        // Each item in 'bounds' represents a startAt/endAt pair. We have to issue
        // a separate query for each pair. There can be up to 9 pairs of bounds
        // depending on overlap, but in most cases there are 4.
        let queryBounds = GFUtils.queryBounds(forLocation: center,
                                              withRadius: radiusInM)
        let queries = queryBounds.map { bound -> Query in
            db.collection("pets")
                .order(by: "hash")
                .start(at: [bound.startValue])
                .end(at: [bound.endValue])
        }

        // Collect all the query results together into a single list
        func getDocumentsCompletion(snapshot: QuerySnapshot?, error: Error?) {
            guard let documents = snapshot?.documents else {
                print("Unable to fetch snapshot data. \(String(describing: error))")
                return
            }

            for document in documents {
                pets.removeAll() // hack to get around issue when changing views duplicates show up
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
                    let date = document.data()["date"] as? String ?? ""

                    //   let geo = data["geo"] as? GeoPoint ?? GeoPoint(latitude: 1, longitude: 1)
                    let path = document.data()["path"] as? String ?? ""
                    let latitude = document.data()["latitude"] as? Double ?? -1.0
                    let longitude = document.data()["longitude"] as? Double ?? -1.0
                    let hash = document.data()["hash"] as? String ?? ""
                    annotations.append(Location(name: name, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)))

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
    }

    //  self.pets = pets.map{ queryDocumentSnapshot -> Pet in
    //  let data = queryDocumentSnapshot.data()

    // self.geoQuery()

    // print(Pet(id: id, name: name, color: color, species: species, date: date, latitude: latitude, longitude: longitude, hash: hash, path: path))
    //

    func setPetImage(withImage: UIImage, andFileName: String) {
        guard let imageData = withImage.jpegData(compressionQuality: 0.0) else { return }
        let storageRef = Storage.storage().reference()
        let thisUserPhotoStorageRef = storageRef.child(andFileName)
        thisUserPhotoStorageRef.putData(imageData, metadata: nil) { metadata, _ in
            guard let metadata = metadata else {
                print("error while uploading")
                return
            }
        }
    }

    func save() {
        addPet(pet)
    }
}
