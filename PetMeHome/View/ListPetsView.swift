//
//  ListPets.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/7/21.
//

import SwiftUI


struct ListPetsView: View {
    @StateObject var petModel = PetModel()
    
    var body: some View {
        
        NavigationView {
            List(petModel.pets) { pet in
                
                NavigationLink(destination: ListPetsDetailsView(pet: pet)) {
                        Text(pet.name).font(.title)
                        
                        
                    
                }
                    
                    
            }
            
            .navigationBarTitle("Pets")
            .onAppear(){
                self.petModel.listPets()
            }
                    
        }
            
            
        }
    }



struct ListPetsView_Previews: PreviewProvider {
    
    static var previews: some View {
        ListPetsView()
    }
}
