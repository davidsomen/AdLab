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
        Form {
            Section(header: Text("API TEST")
            .font(.largeTitle)
                .frame(maxWidth: .infinity)) { EmptyView()}
            
            Section {
                Stepper("Order No. \(viewModel.offset)", value: $viewModel.offset)
                Button("Get Address") {
                    self.viewModel.makeRequest()
                }
            }
            
            if !viewModel.address.fullAddress.isEmpty {
                Section(header: Text("Address")) {
                    Text(viewModel.address.fullAddress).font(.footnote)
                    if !viewModel.address.telephone.isEmpty {
                        Text("Tel: \(viewModel.address.telephone)").font(.footnote)
                    }
                    if !viewModel.address.email.isEmpty {
                        Text("Email: \(viewModel.address.email)").font(.footnote)
                    }
                }
            }
            
            Section(header: Text("Response Body")) {
                Text(viewModel.responseBody).font(.footnote)
            }
        }
    }
}


struct OrdersList_Previews: PreviewProvider {
    static var previews: some View {
        OrdersList()
    }
}
