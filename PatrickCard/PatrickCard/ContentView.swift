//
//  ContentView.swift
//  PatrickCard
//
//  Created by Patrick Spafford on 8/15/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.systemGreen)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Image("poison-dart-frog")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 5))
                Text("Patrick Spafford")
                    .font(Font.custom("SeaweedScript-Regular", size: 40))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                Text("App Developer")
                    .foregroundColor(.white)
                    .font(Font.custom("SeaweedScript-Regular", size: 25))
                InfoView(text: "251-510-0009", imageName: "phone.fill")
                InfoView(text: "patrickspafford1@gmail.com", imageName: "envelope.fill")
                    
            }
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice(PreviewDevice(rawValue: "iPhone X"))
    }
}
