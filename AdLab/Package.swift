//
//  Package.swift
//  AdLab
//
//  Created by David Somen on 14/04/2020.
//  Copyright © 2020 David Somen. All rights reserved.
//

import Foundation

enum PostageType: String, Codable {
    case none = "None"
    case airmail = "AIR MAIL"
    case sal = "SAL"
    
    static var allCases: [Self] {
        return [.none, .airmail, .sal]
    }
}

struct Package: Codable {
    var receiptAddress = Address()
    var returnAddress = Address()
    var isSmallPacket = true
    var postageType = PostageType.none
    var description = ""
    var quantity = 1
    
    var isComplete: Bool {
        receiptAddress.isComplete && returnAddress.isComplete
    }
    
    init() {
        loadReturnAddress()
    }
    
    func saveReturnAddress() {
        let defaults = UserDefaults.standard
        defaults.set(try! PropertyListEncoder().encode(returnAddress), forKey: "ReturnAddress")
    }
    
    mutating func loadReturnAddress() {
        if let data = UserDefaults.standard.value(forKey:"ReturnAddress") as? Data {
            returnAddress = try! PropertyListDecoder().decode(Address.self, from: data)
        }
    }
}
