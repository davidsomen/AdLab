//
//  PackageLabelViewModel.swift
//  AdLab
//
//  Created by David Somen on 04/05/2020.
//  Copyright © 2020 David Somen. All rights reserved.
//

import Foundation
import CoreGraphics

class PackageLabelViewModel: ObservableObject {
    static let RENDER_SIZE = CGSize(width: 500, height: 400)
    
    @Published private var package: Package
    
    required init(package: Package) {
        self.package = package
    }
    
    var showPostageType: Bool {
        package.postageType != .none
    }
    
    var postageType: String {
        package.postageType.rawValue
    }
    
    var showSmallPacket: Bool {
        package.isSmallPacket
    }
    
    var showDescription: Bool {
        !package.description.isEmpty
    }
    
    var description: String {
        "\(package.description)(\(package.quantity))"
    }
    
    var returnAddress: String {
        let address = package.returnAddress
        
        var details = [address.fullAddress]
        if !address.telephone.isEmpty { details.append("TEL: \(address.telephone)") }
        if !address.email.isEmpty { details.append("EMAIL: \(address.email)") }
        
        return details.joined(separator: "\n")
    }
    
    var receiptAddress: String {
        package.receiptAddress.fullAddress
    }
    
    var receiptDetails: String {
        var details = [String]()
        if !package.receiptAddress.telephone.isEmpty { details.append("TEL: \(package.receiptAddress.telephone)") }
        if !package.receiptAddress.email.isEmpty { details.append("EMAIL: \(package.receiptAddress.email)") }
        
        return details.joined(separator: "    |    ")
    }
    
    var showRecieptDetails: Bool {
        !package.receiptAddress.email.isEmpty || !package.receiptAddress.telephone.isEmpty
    }
}
