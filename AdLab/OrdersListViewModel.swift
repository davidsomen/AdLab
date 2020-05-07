//
//  OrdersListViewModel.swift
//  AdLab
//
//  Created by David Somen on 07/05/2020.
//  Copyright © 2020 David Somen. All rights reserved.
//

import Foundation

class OrdersListViewModel: ObservableObject {
    @Published var output: String = ""
    @Published var offset: Int = 0
    
    private let request = EbayRequest()
    
    func makeRequest() {
        request.get(offset: offset) { text in
            DispatchQueue.main.async {
                self.output = text
            }
        }
    }
}
