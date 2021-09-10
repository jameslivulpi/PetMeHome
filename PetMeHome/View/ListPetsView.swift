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

struct childMapView: View {
    @EnvironmentObject var petModel: PetModel
    @StateObject var locationManager = LocationManager()
    var body: some View {
        Map(coordinateRegion: $locationManager.region, interactionModes: MapInteractionModes.all, annotationItems: self.petModel.annotations) {
            MapAnnotation(coordinate: $0.coordinate) {
                Image("dog-face_emoji")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 25)
            }
        }

        .edgesIgnoringSafeArea(.top)
    }
}

struct ListPetsView: View {
    @ObservedObject var petModel = PetModel()
    @State var annotation = MKPointAnnotation()
    @State private var showingMap = false

    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/, spacing: 5) {
            Text("Lost Pets")
            childMapView().environmentObject(petModel)
            Spacer()

            VStack(alignment: .leading, spacing: 5) {
                List(petModel.pets) { pet in // loop over all pets in structure
                    ScrollView {
                        HStack {
                            FirebaseImage(id: pet.path)
                            VStack {
                                Text(pet.name).font(.title)
                                    .font(.headline)
                                Text(pet.species == 0 ? "Pet Type: Dog" : "Pet Type: Cat")
                                    .font(.footnote)
                                Text("Pet color: \(pet.color)")
                                    .font(.footnote)
                                Text("Date Lost: \(pet.date)")
                                    .font(.footnote)
                            }
                        }
                    }
                }
                .id(UUID())
            }
            .onAppear { petModel.geoQuery() }
            Spacer()
        }

        .edgesIgnoringSafeArea(.top)
        .navigationBarTitleDisplayMode(.inline)
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
