//
//  ListPetsDetailsView.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/9/21.
//

import SwiftUI
import MapKit

struct ListPetsDetailsView: View {
    
    let pet : Pet

    
    
    var body: some View {
        VStack(alignment: .leading){
            VStack{
                Text("Pet name: \(pet.name)")
                    .font(.largeTitle)
                    .bold()
                
                Text(pet.species == 0 ? "Pet Type: Dog" : "Pet Type: Cat")
                Text("Pet color: \(pet.color)")
                Text("Date Lost: \(pet.date)")
                Text("Pet Coordinates last seen:")
                Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: pet.geo.latitude, longitude: pet.geo.longitude), span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))), interactionModes: [])
                    .frame(width: 400, height: 300)
        }
                
                
                
                
            
            
                        
    
            
        }
        
    }
}

