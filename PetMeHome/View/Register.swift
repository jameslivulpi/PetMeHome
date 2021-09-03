//
//  Register.swift
//  PetMeHome
//
//  Created by James Livulpi on 8/8/21.
//

import SwiftUI

struct Register: View {
    @StateObject var registerData = RegisterViewModel()
    var body: some View {
        VStack {
            HStack {
                Text("Register")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)

                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }
            .padding()

            ZStack {
                if registerData.image_data.count == 0 {
                    Image(systemName: "person")
                        .font(.system(size: 65))
                        .foregroundColor(.black)
                        .frame(width: 115, height: 115)
                        .background(Color.white)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                } else {
                    Image(uiImage: UIImage(data: registerData.image_data)!)
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/ .fill/*@END_MENU_TOKEN@*/)
                        .frame(width: 115, height: 115)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                }
            }
            .padding(.top)
            .onTapGesture(perform: {
                registerData.picker.toggle()
            })

            if registerData.isLoading {
                ProgressView()
                    .padding()
            } else {
                Button(action: registerData.register, label: {
                    Text("Register")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                        .background(Color("blue"))
                        .clipShape(Capsule())
                })
                    .disabled(registerData.image_data.count == 0 || registerData.name == "" ? true : false)
                    .opacity(registerData.image_data.count == 0 || registerData.name == "" ? 0.5 : 1)
            }
            Spacer(minLength: 0)
        }
        .background(Color("bg").ignoresSafeArea(.all, edges: .all))
    }
}

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        Register()
    }
}
