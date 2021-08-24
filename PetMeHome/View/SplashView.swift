//
//  ContentView.swift
//  petfinder
//
//  Created by James Livulpi on 8/4/21.
//

import SwiftUI
import GoogleSignIn

struct ImageOverlay: View {
    var body: some View {
        ZStack {
            Text("PetMeHome")
                .font(.title).bold()
                .padding()
                .foregroundColor(.white)
                .padding(.top, -275)
            


        }
    }
}


struct HomeImage: View {
    var body: some View{
        Image("home-alt")
            .scaleEffect(CGSize(width: 0.33, height: 0.5), anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}


struct SplashView: View {
    @State var isActive:Bool = false
   

    var body: some View {
        
        VStack(alignment: .center) {
            if self.isActive {
                MainMenuView()
                    
                
            }else{
                HomeImage()
                    .overlay(ImageOverlay())
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                withAnimation {
                    self.isActive = true
                }
                    
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
