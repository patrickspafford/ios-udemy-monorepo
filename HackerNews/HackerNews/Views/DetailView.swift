//
//  DetailView.swift
//  HackerNews
//
//  Created by Patrick Spafford on 8/16/21.
//
import Foundation
import SwiftUI
import WebKit

struct DetailView: View {
    var url: String?
    var body: some View {
        WebView(urlString: url)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://google.com")
    }
}
