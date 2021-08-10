//
//  EnterLostPet.swift
//  petfinder
//
//  Created by James Livulpi on 8/5/21.
//

import SwiftUI

import CoreLocation
import Foundation
import MapKit    
import UIKit
import FirebaseFirestore
import Combine 




struct EnterLostPetView: View {
    
    @State private var petsName = ""
    @State private var petsColor = ""
    @State private var petsSpecies = 0
    @State private var petHaveCollar = ""
    @State private var petLostDate = Date()
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image = UIImage()
    @State private var submit = false
    let dateFormatter = DateFormatter()
    
    @StateObject var petModel = PetModel()
    @StateObject var locationManager = LocationManager()

    
    var body: some View {
        
        
        NavigationView{
                
            Form{
                
                
                Section(header: Text("What is your pets name?")){
                    TextField("Name", text: self.$petModel.pet.name)
                }
                Section(header: Text("What is your pets color?")){
                    TextField("Color", text: self.$petModel.pet.color)
                }
                Section(header: Text("What is your pets species?")){
                    Picker("Pet Species", selection: self.$petModel.pet.species){
                        ForEach(0 ..< self.petModel.specieslist.count) {
                            Text("\(self.petModel.specieslist[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                }
                
                Section(header: Text("Select photo")){
                    
                    Image(uiImage: self.image)
                                   .resizable()
                                   .scaledToFill()
                                   .frame(minWidth: 0, maxWidth: .infinity)
                                   .edgesIgnoringSafeArea(.all)
                    
                               Button(action: {
                                   self.showingImagePicker = true
                               }) {
                                   HStack {
                                       Image(systemName: "photo")
                                           .font(.system(size: 20))
                    
                                       Text("Photo library")
                                           .font(.headline)
                                   }
                                   .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                                   .background(Color.blue)
                                   .foregroundColor(.white)
                                   .cornerRadius(20)
                                   .padding(.horizontal)
                               }
                               
                }
                
                Section(header: Text("When did you pet go Missing?")){
                    DatePicker("Date", selection: self.$petModel.pet.date)
                    
                }
                
                Section{
                    Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                                .frame(width: 300, height: 300)
                }
                
                
                Section{
                    NavigationLink(destination: MainMenuView().navigationBarBackButtonHidden(true).onAppear{
                        self.handleSubmit()
                    }) {
                    //Button(action: {self.handleSubmit()}) {
                        Text("submit")
                        
                    }
                        
                }
                
                }
            .navigationBarTitle("Lets Find \(self.petModel.pet.name)")
                
            }
            
        
    
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
            
        
        
        }
        
    }
    func handleSubmit(){
        self.petModel.pet.geo = GeoPoint(latitude: locationManager.region.center.latitude, longitude: locationManager.region.center.longitude)
        self.petModel.save()
    
    }
    
}

    





struct EnterLostPetView_Previews: PreviewProvider {
    static var previews: some View {
        EnterLostPetView()
    }
}
