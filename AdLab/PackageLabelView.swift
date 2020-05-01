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
        VStack(spacing: 0) {
            HStack(spacing: 0.0) {
                VStack(spacing: 0.0) {
                    //Text("Return Address")
                    //    .minimumScaleFactor(0.5)
                    //.rotationEffect(.degrees(-90))
                    Rectangle()
                        //.stroke(Color.black)
                        .foregroundColor(.clear)
                        .overlay(
                            Text(package.returnAddress.fullAddress)
                                .font(.body)
                                .padding(5)
                                .minimumScaleFactor(0.5)
                                .padding(10),
                            alignment: .topLeading)
                }
                Divider().frame(width: 1).background(Color.black)
                Rectangle()
                    .foregroundColor(.clear)
                    .overlay(
                        VStack(alignment: .trailing, spacing: 0.0) {
                            if package.isSmallPacket {
                                Text("SMALL PACKET")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .minimumScaleFactor(0.1)
                                    .padding(5)
                                Divider().frame(height: 1).background(Color.black)
                            }
                            if package.postageType != .none {
                                Text(package.postageType.rawValue)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .minimumScaleFactor(0.5)
                                    .padding(5)
                                Divider().frame(height: 1).background(Color.black)
                            }
                        },
                        alignment: .topTrailing)
            }.frame(height: 150)
            Divider().frame(height: 1).background(Color.black)
            Rectangle()
                .foregroundColor(.clear)
                .overlay(
                    Text(package.receiptAddress.fullAddress)
                        .padding(15)
                        .minimumScaleFactor(0.5)
                        .font(.title),
                    alignment: .leading)
        }.border(Color.black)
            .frame(width: PackageLabelView.RENDER_SIZE.width,
                   height: PackageLabelView.RENDER_SIZE.height)
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
        Form {
            PackageLabelMiniPreview(package: package)
        }
    }
}

#endif
