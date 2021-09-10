//
//  petfinderApp.swift
//  petfinder
//
//  Created by James Livulpi on 8/4/21.
//

import Firebase
import FirebaseAuthUI
import FirebaseFirestore
import SwiftUI

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

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _:
        [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool
    {
        FirebaseApp.configure()
        Firestore.firestore().useEmulator(withHost: "192.168.1.204", port: 8054)

        Storage.storage().useEmulator(withHost: "192.168.1.204", port: 8095)

        let settings = Firestore.firestore().settings
        settings.isPersistenceEnabled = true
        settings.isSSLEnabled = false
        Firestore.firestore().settings = settings
        return true
    }
}
