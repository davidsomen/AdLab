//
//  Package.swift
//  AdLab
//
//  Created by David Somen on 14/04/2020.
//  Copyright © 2020 David Somen. All rights reserved.
//

enum PostageType: String {
    case airmail = "AIRMAIL"
    case sal = "SAL"
}

struct Address {
    var street: String = ""
    var city: String = ""
    var state: String = ""
    var postcode: String = ""
    var country: String = ""
    var telephone: String = ""
    var email: String = ""
    
    var isComplete: Bool {
        !street.isEmpty &&
            !country.isEmpty &&
            !postcode.isEmpty
    }
    
    var fullAddress: String {
        [street, city, state, postcode, country]
            .filter { !$0.isEmpty }
            .joined(separator: "\n")
    }
}

struct Package {
    var toAddress = Address()
    var fromAddress = Address()
    var isSmallPacket: Bool = true
    var postageType: PostageType = .airmail
}
