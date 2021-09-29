//
//  NetworkData.swift
//  HackerNews
//
//  Created by Patrick Spafford on 8/15/21.
//

import Foundation

struct Results: Decodable {
    let hits: [Post]
}


struct Post: Decodable, Identifiable {
    let objectID: String
    let points: Int
    let title: String
    let url: String?
    var id: String {
        return objectID
    }
}
