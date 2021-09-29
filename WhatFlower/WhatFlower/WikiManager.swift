//
//  WikiManager.swift
//  WhatFlower
//
//  Created by Patrick Spafford on 9/2/21.
//

import Foundation
import SwiftyJSON
import Alamofire

struct WikiManager {
    let wikipediaURl = "https://en.wikipedia.org/w/api.php"
    
    let parameters : [String:String] = [
    "format" : "json",
    "action" : "query",
    "prop" : "extracts",
    "exintro" : "",
    "explaintext" : "",
    "indexpageids" : "",
    "redirects" : "1",
    ]
    
}
