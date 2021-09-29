//
//  InfoView.swift
//  PatrickCard
//
//  Created by Patrick Spafford on 8/15/21.
//

import SwiftUI

struct InfoView: View {
    let text: String
    let imageName: String
    var body: some View {
        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
            .foregroundColor(.white)
            .frame(height: 50)
            .overlay(
                HStack {
                    Image(systemName: imageName)
                    Text(text)
                        .foregroundColor(.black)
                })
            .padding()
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "Hello", imageName: "phone.fill").previewLayout(.sizeThatFits)
    }
}
