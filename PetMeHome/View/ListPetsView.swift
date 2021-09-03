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
            Section {
                // ForEach(self.petModel.pets) {pet in
                Map(coordinateRegion: $locationManager.region, interactionModes: MapInteractionModes.all, annotationItems: self.petModel.annotations) {
                    MapAnnotation(coordinate: $0.coordinate) {
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 25)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.blue, lineWidth: 25 / 10))
                            .shadow(radius: 10)
                    }
                }
                Spacer()
                // }
            }
            ZStack {
                ScrollView {
                    ForEach(self.petModel.pets) { pet in

                        // List(petModel.pets) { pet in //loop over all pets in structure

                        //  let newAnnotation = [location(name: pet.name, coordinate: CLLocationCoordinate2D(latitude: pet.latitude, longitude: pet.longitude))]
                        Section {
                            Text(pet.name).font(.title)

                            FirebaseImage(id: pet.path)

                            Text(pet.species == 0 ? "Pet Type: Dog" : "Pet Type: Cat")
                            // .padding()
                            Text("Pet color: \(pet.color)")
                            // .padding()
                            Text("Date Lost: \(pet.date)")
                            //    .padding()
                            Section {
                                // Text("Pet Coordinates last seen:")
                                Button(action: {
                                    withAnimation {
                                        self.showingMap = true
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: "map")
                                            .font(.headline)

                                        Text("Map")
                                            .font(.headline)
                                    }

                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 25)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
            }
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
