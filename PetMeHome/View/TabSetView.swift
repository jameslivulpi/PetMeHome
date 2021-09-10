//
//  TabSetView.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/15/21.
//

import SwiftUI

struct TabSetView: View {
    @StateObject var petModel = PetModel()

    @State private var currentTab = 2
    var body: some View {
        TabView(selection: $currentTab) {
//            SignedMenuView()
//                .tabItem {
//                    Image(systemName: "house.fill")
//                    Text("Main Menu")
//                }
//                .tag(1)

            ListPetsView()

                .tabItem {
                    Image(systemName: "list.dash")
                    Text("List Pets")
                }

                .tag(0)

            EnterLostPetView(isActive: true)
                .tabItem {
                    Image(systemName: "plus.square.fill")
                    Text("Add Lost Pet")
                }
                .tag(1)

            MenuView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Settings")
                }
                .tag(2)
        }
    }
}

struct TabSetView_Previews: PreviewProvider {
    static var previews: some View {
        TabSetView()
    }
}
