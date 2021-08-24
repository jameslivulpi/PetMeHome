//
//  ListPets.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/7/21.
//

import SwiftUI
import MapKit
import CoreLocation


struct AnnotationItem: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}


struct ListPetsView: View {
    @StateObject var petModel = PetModel()
    @State var annotation = MKPointAnnotation()
    @State private var showingMap = false
    
    
    
    var body: some View {
        ZStack{
            List(petModel.pets) { pet in //loop over all pets in structure
                let newAnnotation = [location(name: pet.name, coordinate: CLLocationCoordinate2D(latitude: pet.latitude, longitude: pet.longitude))]

    
                Section{
                    Text(pet.name).font(.title)
                    
                    VStack{
                        
                        FirebaseImage(id: pet.path)
                 
                        
                        Text(pet.species == 0 ? "Pet Type: Dog" : "Pet Type: Cat")
                            // .padding()
                        Text("Pet color: \(pet.color)")
                           // .padding()
                        Text("Date Lost: \(pet.date)")
                        //    .padding()
                        Section{
                        //Text("Pet Coordinates last seen:")
                            Button(action: {
                             withAnimation{
                                self.showingMap = true
                             }
                            }){
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
            
                

                .sheet(isPresented: $showingMap){
                    
                    Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: pet.latitude, longitude: pet.longitude), span: MKCoordinateSpan(latitudeDelta: 0.2   , longitudeDelta: 0.2))), annotationItems: newAnnotation){
                        MapMarker(coordinate: $0.coordinate, tint: Color.purple)
                        
                    }
                    
                    
                    
                    //.frame(width: 300, height: 200)
                   .padding()
                
                }
                
            
                
               
                    
            }
            .environmentObject(petModel)
           
        
           
            
        
                    

            
        //.navigationBarTitle("Pets")
        
    }
        
        .onAppear{
        
            petModel.listPets()
        }
        
        
        
 
        
    
    }
    
    private func fetch(){
        self.petModel.geoQuery()
    }
    
    
    
        
    

}





struct ListPetsView_Previews: PreviewProvider {
    
    static var previews: some View {
        ListPetsView()
    }
}
