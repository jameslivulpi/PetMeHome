//
//  ListPetsDetailsView.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/9/21.
//

import MapKit
import SwiftUI

struct ListPetsDetailsView: View {
    let pet: Pet

    var body: some View {
        //  let annotations = CLLocationCoordinate2D(latitude: pet.geo.latitude, longitude: pet.geo.longitude)

        VStack(alignment: .leading) {
            VStack {
                Text("Pet name: \(pet.name)")
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading)

                Text(pet.species == 0 ? "Pet Type: Dog" : "Pet Type: Cat")
                    .padding()
                Text("Pet color: \(pet.color)")
                    .padding()
                Text("Date Lost: \(pet.date)")
                    .padding()
                Section {
                    Text("Pet Coordinates last seen:")

                    Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: pet.latitude, longitude: pet.longitude), span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))))
                        .frame(width: 300, height: 200)
                        .padding()
                }
            }
        }
    }
}
