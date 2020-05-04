//
//  PackageLabelView.swift
//  AdLab
//
//  Created by David Somen on 30/04/2020.
//  Copyright © 2020 David Somen. All rights reserved.
//

import SwiftUI

struct PackageLabelView: View {
    @ObservedObject var viewModel: PackageLabelViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                Text(viewModel.returnAddress)
                    .modifier(ReturnAddressStyle())
                    .fixedSize()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider().frame(width: 1).background(Color.black)
                
                VStack(alignment: .trailing, spacing: 0) {
                    if viewModel.isSmallPacket {
                        Text("SMALL PACKET")
                            .modifier(LabelStyle())
                        Divider().frame(height: 1).background(Color.black)
                    }
                    if !viewModel.postageType.isEmpty {
                        Text(viewModel.postageType)
                            .modifier(LabelStyle())
                        Divider().frame(height: 1).background(Color.black)
                    }
                }
            }
            
            Divider().frame(height: 1).background(Color.black)
            
            Text(viewModel.receiptAddress)
                .modifier(ReceiptAddressStyle())
                .fixedSize()
                .frame(maxHeight: .infinity)
                .layoutPriority(1)
            if !viewModel.receiptDetails.isEmpty {
                Text(viewModel.receiptDetails).modifier(ReturnAddressStyle())
            }
        }.border(Color.black)
            .frame(width: PackageLabelViewModel.RENDER_SIZE.width,
                   height: PackageLabelViewModel.RENDER_SIZE.height)
            .background(Color.white)
    }
}

struct ReturnAddressStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 12))
            .foregroundColor(.black)
            .padding(10)
    }
}

struct ReceiptAddressStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 25))
            .foregroundColor(.black)
            .padding(20)
    }
}

struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 30, weight: .bold))
            .foregroundColor(.black)
            .padding(5)
    }
}

#if DEBUG

struct PackageLabelView_Previews: PreviewProvider {
    static private var package: Package {
        let path = Bundle.main.path(forResource: "TestPackage", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return try! JSONDecoder().decode(Package.self, from: data)
    }
    
    static var previews: some View {
        PackageLabelView(viewModel: PackageLabelViewModel(package: package))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

#endif
