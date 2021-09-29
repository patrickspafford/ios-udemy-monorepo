//
//  NetworkManager.swift
//  HackerNews
//
//  Created by Patrick Spafford on 8/15/21.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts: [Post] = []
    
    func fetchData() {
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url, completionHandler: {(data, response, err) in
                if err == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            })
            task.resume()
        }
    }
}
