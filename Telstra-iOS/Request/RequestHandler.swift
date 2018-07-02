//
//  RequestHandler.swift
//  Telstra-iOS
//
//  Created by Hitesh on 6/29/18.
//  Copyright © 2018 Hitesh. All rights reserved.
//

import Foundation

let countryEndPoint: String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

class RequestHandler {
    
    typealias Result = (Country?, String?) -> ()
    
    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    
    func requestCountryData(completion: @escaping Result) {
        
        dataTask?.cancel()
        
        var errorMessage: String?
        var countryData: Country?
        
        guard let url = URL(string: countryEndPoint) else {
            print("Error: cannot create URL")
            return
        }
        
        ReachabilityManager.isReachable { _ in
            
            self.dataTask = self.defaultSession.dataTask(with: url) { [weak self] (data, response, error) in
                defer { self?.dataTask = nil }
                
                if let error = error {
                    errorMessage = "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = self?.trimResult(data), //trim data string to avoid json error
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    do {
                        countryData = try JSONDecoder().decode(Country.self, from: data)
                    } catch let jsonError {
                        errorMessage = "JSON error: " + jsonError.localizedDescription + "\n"
                    }
                }
                
                DispatchQueue.main.async {
                    completion(countryData, errorMessage)
                }
            }
            
            self.dataTask?.resume()
        }
        
        ReachabilityManager.isUnreachable { _ in
            errorMessage = "You are offline"
            completion(countryData, errorMessage)
        }
    }
    
    fileprivate func trimResult(_ data: Data?) -> Data? {
        if let data = data {
            let jsonString = String(decoding: data, as: UTF8.self)
            return jsonString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).data(using: String.Encoding.utf8)
        }
        
        return nil
    }
    
}
