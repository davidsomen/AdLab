//
//  OrdersListViewModel.swift
//  AdLab
//
//  Created by David Somen on 07/05/2020.
//  Copyright © 2020 David Somen. All rights reserved.
//

import Foundation

class OrdersListViewModel: ObservableObject {
    @Published var address: Address = Address()
    @Published var responseBody: String = ""
    @Published var offset: Int = 0
    
    private let request = EbayRequest()
    
    func makeRequest() {
        request.get(offset: offset) { responseBody, address in
            DispatchQueue.main.async {
                self.responseBody = responseBody
                if let address = address { self.address = address }
            }
        }
    }
}
