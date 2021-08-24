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
import Firebase
import GeoFire




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
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    let storageRef = Storage.storage().reference()
    let dateFormatter = DateFormatter()
    @State var hideAddButton = false
    @StateObject var petModel = PetModel()
    @State var centerCoordinate = CLLocationCoordinate2D()
    @State var currentLocation: CLLocationCoordinate2D?
    @State var annotation: MKPointAnnotation?
    @State var isActive: Bool
    @State var enteredLocation: CLLocationCoordinate2D?
    @ObservedObject private var locationManager = LocationManager()
    @State var curruid = Auth.auth().currentUser?.uid
   


   // @StateObject var locationManager = LocationManager()
    var homeLocation : [AnnotationItem] {
         guard let location = locationManager.location?.coordinate else {
             return []
         }
         return [.init(name: "Home", coordinate: location)]
     }

    
    var body: some View {
        
        
       // NavigationView{
                
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
                    if(self.image.size.width == 0){
                        Image("dog-placeholder")
                            .resizable()
                           .scaledToFill()
                            .frame(height: 320)
                           .edgesIgnoringSafeArea(.all)
                    }else{
                    
                        Image(uiImage: self.image)
                                    .resizable()
                                   .scaledToFill()
                                    .frame(height: 320)
                                   .edgesIgnoringSafeArea(.all)
                    }
                    
                               Button(action: {
                                withAnimation{
                                   self.showingImagePicker = true
                                }
                               }) {
                                   HStack {
                                       Image(systemName: "photo")
                                        .font(.headline)
                    
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
                    ZStack {
                    
                        MapView(centerCoordinate: $locationManager.region.center, currentLocation: locationManager.region.center)
                        //Map(coordinateRegion: $locationManager.region, annotationItems: homeLocation) {
                         //           MapMarker(coordinate: $0.coordinate)
                       // }
                    
                             
                                  
                            
                            }
                           

                }
                
                           .frame(width: 300, height: 300)

                Section{
                    NavigationLink(destination: MainMenuView().navigationBarBackButtonHidden(true).onAppear{
                        self.handleSubmit()
                    }) {
                    //Button(action: {self.handleSubmit()}) {
                        Text("submit")
                        
                    }
                        
                }
                
            //    }
           // .navigationBarTitle("Lets Find \(self.petModel.pet.name)")
           // .navigationBarTitleDisplayMode(.inline)

                
            }
            
        
    
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
        
    }

    func handleSubmit(){
        self.petModel.pet.id = "\(UUID())"
        if let location = currentLocation {
            enteredLocation = location
            isActive = false
        } else if annotation != nil {
            enteredLocation = centerCoordinate
            isActive = false
        }
        
        self.petModel.pet.latitude =  locationManager.region.center.latitude
        self.petModel.pet.longitude = locationManager.region.center.longitude
        
        let location = CLLocationCoordinate2D(latitude: self.petModel.pet.latitude , longitude: self.petModel.pet.longitude)
        self.petModel.pet.hash = GFUtils.geoHash(forLocation: location)
       

        self.petModel.setPetImage(withImage: self.image, andFileName: "\(curruid!)-\(self.petModel.pet.name).jpg")
        self.petModel.pet.path = "\(curruid!)-\(self.petModel.pet.name).jpg"
    
        self.petModel.save()
    
    }
    
}
    
    



struct AddButton: View {
     
     var parent: EnterLostPetView
     
     init(_ parent: EnterLostPetView) {
         self.parent = parent
     }
     
     var body: some View {
         VStack {
             Spacer()
             HStack {
                 Spacer()
                 Button(action: {
                     let location = MKPointAnnotation()
                     location.coordinate = parent.centerCoordinate
                     parent.annotation = location
                 }) {
                     Image(systemName: "plus")
                         .padding()
                         .background(Color.black.opacity(0.75))
                         .foregroundColor(.white)
                         .font(.title)
                         .clipShape(Circle())
                         .padding(.trailing)
                 }
             }
         }
     }
 }







struct EnterLostPetView_Previews: PreviewProvider {
    static var previews: some View {
        EnterLostPetView(isActive: true)
    }
}
