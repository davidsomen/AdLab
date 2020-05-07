//
//  OrdersList.swift
//  AdLab
//
//  Created by David Somen on 07/05/2020.
//  Copyright © 2020 David Somen. All rights reserved.
//

import SwiftUI

struct OrdersList: View {
    @ObservedObject var viewModel = OrdersListViewModel()
    
    var body: some View {
        VStack {
            Text("API TEST")
                .font(.largeTitle)
            Stepper("Order: \(viewModel.offset)", value: $viewModel.offset).padding()
            Button("Get Buyer Username") {
                self.viewModel.makeRequest()
            }
            Divider()
            Text(viewModel.output).padding()
            Spacer()
        }
    }
}

struct OrdersList_Previews: PreviewProvider {
    static var previews: some View {
        OrdersList()
    }
}
