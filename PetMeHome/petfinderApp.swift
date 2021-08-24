//
//  petfinderApp.swift
//  petfinder
//
//  Created by James Livulpi on 8/4/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuthUI

@main
struct petfinderApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    
    var body: some Scene {
        WindowGroup {
            let viewModel = LoginViewModel()
            SplashView()
                .environmentObject(viewModel)
                
            
            
        }
        
    }
}

class AppDelegate: NSObject,UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
                        [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
         FirebaseApp.configure()
        Firestore.firestore().useEmulator(withHost: "localhost", port: 8092)



    

        let settings = Firestore.firestore().settings
        settings.isPersistenceEnabled = true
        settings.isSSLEnabled = false
        Firestore.firestore().settings = settings
        return true
    }
    

}

