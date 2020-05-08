//
//  Network.swift
//  AdLab
//
//  Created by David Somen on 07/05/2020.
//  Copyright © 2020 David Somen. All rights reserved.
//

import Foundation

class EbayRequest {
    func get(limit: Int = 1, offset: Int = 0, completionHandler: @escaping (String, Address?) -> ()) {
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
                
                if let contact = root.orders?.first?.fulfillmentStartInstructions?.first?.shippingStep?.shipTo {
                    let countryName = Locale.current.localizedString(forRegionCode: contact.contactAddress.countryCode)!
                    
                    // TODO: Missing addressLine2
                    let address = Address(
                        name: contact.fullName,
                        street: contact.contactAddress.addressLine1,
                        city: contact.contactAddress.city,
                        state: contact.contactAddress.stateOrProvince,
                        postcode: contact.contactAddress.postalCode,
                        country: countryName,
                        telephone: contact.primaryPhone.phoneNumber ?? "",
                        email: contact.email ?? "")
                    
                    completionHandler(String(data: data, encoding: .utf8)!, address)
                } else {
                    completionHandler(String(data: data, encoding: .utf8)!, nil)
                    print(String(data: data, encoding: .utf8)!)
                }
            } catch {
                print(error)
            }
        })
        
        task.resume()
    }
}
