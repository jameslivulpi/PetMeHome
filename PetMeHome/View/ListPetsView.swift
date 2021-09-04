//
//  ListPets.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/7/21.
//

import CoreLocation
import MapKit
import SwiftUI

struct AnnotationItem: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ListPetsView: View {
    @StateObject var petModel = PetModel()
    @State var annotation = MKPointAnnotation()
    @State private var showingMap = false
    @StateObject var locationManager = LocationManager()

    var body: some View {
        VStack {
            Text("Lost Pets")
            Section {
                // ForEach(self.petModel.pets) {pet in
                Map(coordinateRegion: $locationManager.region, interactionModes: MapInteractionModes.all, annotationItems: self.petModel.annotations) {
                    MapAnnotation(coordinate: $0.coordinate) {
                        Image("dog-face_emoji")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 25)
                    }
                }

                // }
            }
            Spacer()

            VStack {
                // List{

                // ForEach(petModel.pets) { pet in

                List(petModel.pets) { pet in // loop over all pets in structure
                    ScrollView {
                        //  let newAnnotation = [location(name: pet.name, coordinate: CLLocationCoordinate2D(latitude: pet.latitude, longitude: pet.longitude))]

                        Text(pet.name).font(.title)

                        FirebaseImage(id: pet.path)

                        Text(pet.species == 0 ? "Pet Type: Dog" : "Pet Type: Cat")
                        // .padding()
                        Text("Pet color: \(pet.color)")
                        // .padding()
                        Text("Date Lost: \(pet.date)")
                        //    .padding()
                    }
                }
            }
            Spacer()
        }
        .onAppear { petModel.listPets() }
    }

    private func fetch() {
        petModel.geoQuery()
    }
}

struct ListPetsView_Previews: PreviewProvider {
    static var previews: some View {
        ListPetsView()
    }
}
