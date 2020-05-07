//
//  Network.swift
//  AdLab
//
//  Created by David Somen on 07/05/2020.
//  Copyright © 2020 David Somen. All rights reserved.
//

import Foundation

class EbayRequest {
    func get(limit: Int = 0, offset: Int = 0, completionHandler: @escaping (String) -> ()) {
        let accessToken = "Bearer " + "" // <-- TODO: NEED USER ACCESS TOKEN
        
        var urlComponents = URLComponents(string: "https://api.ebay.com/sell/fulfillment/v1/order")!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "filter", value: "orderfulfillmentstatus:"+"%7B" + "NOT_STARTED" + "%7C" + "IN_PROGRESS" + "%7D"),
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "offset", value: "\(offset)")
        ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.addValue(accessToken, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            do {
                let root = try JSONDecoder().decode(EBRoot.self, from: data)
                
                if let username = root.orders?.first?.buyer?.username {
                    completionHandler(username)
                } else {
                    completionHandler(String(data: data, encoding: .utf8)!)
                }
            } catch {
                print(error)
            }
        })
        
        task.resume()
    }
}
