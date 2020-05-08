//
//  Address.swift
//  AdLab
//
//  Created by David Somen on 04/05/2020.
//  Copyright © 2020 David Somen. All rights reserved.
//

import Foundation

struct Address: Codable {
    var name = ""
    var street = ""
    var city = ""
    var state = ""
    var postcode = ""
    var country = "" {
        didSet {
            country = country.uppercased()
        }
    }
    var telephone = ""
    var email = ""
    
    var isComplete: Bool {
        !name.isEmpty && !street.isEmpty && !country.isEmpty && !postcode.isEmpty
    }
    
    var fullAddress: String {
        [name, street, city, state, postcode, country]
            .filter { !$0.isEmpty }
            .joined(separator: "\n")
    }
}
