//
//  PackageLabelView.swift
//  AdLab
//
//  Created by David Somen on 30/04/2020.
//  Copyright © 2020 David Somen. All rights reserved.
//

import SwiftUI

struct PackageLabelView: View {
    let package: Package
    
    static let RENDER_SIZE = CGSize(width: 500, height: 400)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                Text(package.returnAddress.fullAddress)
                    .modifier(ReturnAddressStyle())
                    .fixedSize()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider().frame(width: 1).background(Color.black)
                VStack(alignment: .trailing, spacing: 0) {
                    if package.isSmallPacket {
                        Text("SMALL PACKET")
                            .modifier(LabelStyle())
                        Divider().frame(height: 1).background(Color.black)
                    }
                    if package.postageType != .none {
                        Text(package.postageType.rawValue)
                            .modifier(LabelStyle())
                        Divider().frame(height: 1).background(Color.black)
                    }
                }
            }
            Divider().frame(height: 1).background(Color.black)
            Text(package.receiptAddress.fullAddress)
                .modifier(ReceiptAddressStyle())
                .frame(maxHeight: .infinity)
                .layoutPriority(1)
        }.border(Color.black)
            .frame(width: PackageLabelView.RENDER_SIZE.width,
                   height: PackageLabelView.RENDER_SIZE.height)
            .background(Color.white)
    }
}

struct ReturnAddressStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 15))
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
        PackageLabelView(package: package)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

#endif
