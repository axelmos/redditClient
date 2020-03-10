//
//  APIClient.swift
//  RedditClient
//
//  Created by Axel Mosiejko on 08/03/2020.
//  Copyright © 2020 Axel Mosiejko. All rights reserved.
//

import Foundation

class APIClient {
    
    static var shared: APIClient = { return APIClient() }()
    private init(){}
    
    public func getFrontPage(completion: @escaping (Model?) -> Void) {
        
        //"https://www.reddit.com/r/all/.json"
        //"https://www.reddit.com/r/redditdev/top.json"
        
        guard let url = URL(string: "https://www.reddit.com/r/all/.json") else { fatalError("Invalid URL") }
        
        URLSession.shared.dataTask(with: url) { data, response, err in
            if(err != nil) {
                completion(nil)
            }
            guard let httpResponse = response as? HTTPURLResponse else { fatalError("URL Response Error") }
            switch httpResponse.statusCode {
            case 200:
                if let data = data {
                    do {
                        
                        let data = try JSONDecoder().decode(Model.self, from: data)
                        completion(data)
                        
                    } catch {
                        print("ERROR DECODING JSON \(err.debugDescription)")
                    }
                }
                break
            default:
                completion(nil)
                break
            }
        }.resume()
    }
}
