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
        HStack(spacing: 5) {
            if viewModel.showDescription {
                Text(viewModel.description)
                    .modifier(DescriptionStyle())
            }
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .top, spacing: 0) {
                    if viewModel.showReturnAddress {
                        Text("RETURN")
                            .modifier(SideLabelStyle())
                        Text(viewModel.returnAddress)
                            .modifier(ReturnAddressStyle())
                    }
                    
                    Spacer().layoutPriority(1)
                    
                    Divider().frame(width: 1).overlay(Color.black)
                    
                    VStack(alignment: .trailing, spacing: 0) {
                        if viewModel.showSmallPacket {
                            Text("SMALL PACKET")
                                .modifier(LabelStyle())
                                .fixedSize()
                            
                            if viewModel.showPostageType {
                                Divider().frame(height: 1).overlay(Color.black)
                            }
                        }
                        if viewModel.showPostageType {
                            Text(viewModel.postageType)
                                .modifier(LabelStyle())
                        }
                    }
                }
                
                Divider().frame(height: 1).overlay(Color.black)
                
                HStack(spacing: 10) {
                    Text("TO")
                        .modifier(SideLabelStyle())
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(viewModel.receiptAddress)
                            .modifier(ReceiptAddressStyle())
                        
                        if viewModel.showRecieptDetails {
                            Text(viewModel.receiptDetails).modifier(ReceiptDetailsStyle())
                        }
                    }
                }.frame(maxHeight: .infinity)
                    .layoutPriority(1)
            }.border(Color.black)
        }.frame(width: PackageLabelViewModel.RENDER_SIZE.width,
                height: PackageLabelViewModel.RENDER_SIZE.height)
            .background(Color.white)
            .preferredColorScheme(.light)
    }
}

struct ReceiptDetailsStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 12))
            .fixedSize()
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}


struct DescriptionStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 12))
            .rotationEffect(.degrees(-90))
            .fixedSize()
            .frame(width: 20)
    }
}

struct SideLabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 15, weight: .bold))
            .rotationEffect(.degrees(-90))
            .fixedSize()
            .frame(width: 20)
            .frame(maxHeight: .infinity)
            .frame(minHeight: 70)
            .padding(5)
    }
}

struct ReturnAddressStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 12))
            .fixedSize()
            .padding(10)
    }
}

struct ReceiptAddressStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 25))
            .fixedSize()
    }
}

struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 28, weight: .bold))
            .lineLimit(1)
            .fixedSize()
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
