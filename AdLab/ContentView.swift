//
//  ContentView.swift
//  AdLab
//
//  Created by David Somen on 02/04/2020.
//  Copyright © 2020 David Somen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            PackageForm()
        }
    }
}

struct ConectView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AddressForm: View {
    var address: Binding<Address>
    
    var addressView: some View {
        Section(header: Text("Address")) {
            TextField("Street", text: address.street)
            TextField("City", text: address.city)
            TextField("State", text: address.state)
            TextField("Post Code", text: address.postcode)
            TextField("Country", text: address.country)
        }
    }
    
    var contactView: some View {
        Section() {
            TextField("Telephone", text: address.telephone).keyboardType(.numberPad)
            TextField("Email", text: address.email).keyboardType(.emailAddress)
        }
    }
    
    var body: some View {
        Form {
            addressView
            contactView
        }
    }
}

struct PackageForm: View {
    @State private var package = Package()
    
    var body: some View {
        Form {
            Section {
                NavigationLink("Return Address", destination:
                    AddressForm(address: $package.fromAddress).body
                        .navigationBarTitle("Return Address")
                )
            }
            
            AddressForm(address: $package.toAddress).addressView
            AddressForm(address: $package.toAddress).contactView
            
            Section(header: Text("Postage Type")) {
                Picker("Postage Type", selection: $package.postageType) {
                    Text("AIRMAIL").tag(PostageType.airmail)
                    Text("SAL").tag(PostageType.sal)
                }.pickerStyle(SegmentedPickerStyle())
                Toggle(isOn: $package.isSmallPacket) {
                Text("Small Packet")
                }
            }
            
            Section(header: Text("Preview")) {
                PackageLabelMiniPreview(package: package)
            }
            
            Section(footer: Text(package.toAddress.isComplete ? "" : "Please fill in all fields.").foregroundColor(.red)) {
                Button(action: {}) {
                    Text("Generate PDF")
                }
            }.disabled(!package.toAddress.isComplete)
        }.navigationBarTitle("AdLab").navigationBarItems(trailing: Button(action: {}) {
            Text("Fill")
        })
    }
}

struct HDivider: View {
    var body: some View {
        Rectangle().frame(height: 1)
    }
}

struct VDivider: View {
    var body: some View {
        Rectangle().frame(width: 1)
    }
}

struct PackageLabelPreview: View {
    let package: Package
    
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
                            Text(package.fromAddress.fullAddress)
                                .font(.body)
                                .padding(5)
                                .minimumScaleFactor(0.5)
                                .padding(10),
                            alignment: .topLeading)
                }
                VDivider()
                Rectangle()
                    .foregroundColor(.clear)
                    .overlay(
                        VStack(alignment: .trailing, spacing: 0.0) {
                            if package.isSmallPacket {
                                Text("SMALL PACKAGE")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .minimumScaleFactor(0.1)
                                    .padding(5)
                                HDivider()
                            }
                            Text(package.postageType.rawValue)
                                .font(.title)
                                .fontWeight(.bold)
                                .minimumScaleFactor(0.5)
                                .padding(5)
                            HDivider()
                        },
                        alignment: .topTrailing)
            }.frame(height: 150)
            HDivider()
            Rectangle()
                .foregroundColor(.clear)
                .overlay(
                    Text(package.toAddress.fullAddress)
                        .padding(15)
                        .minimumScaleFactor(0.5)
                        .font(.title),
                    alignment: .leading)
            }.border(Color.black)
            .padding(5)
            .frame(width: 500, height: 400)
    }
}

struct PackageLabelMiniPreview: View {
    var package: Package
    
    var body: some View {
        let scale: CGFloat = 0.7
        
        return PackageLabelPreview(package: package)
            .scaleEffect(scale, anchor: .topLeading)
            .frame(width: 500 * scale, height: 400 * scale, alignment: .topLeading)
    }
}

struct PackageLabelPreview_Previews: PreviewProvider {
    static var toAddress = Address(
        street: "24 East Avenue",
        city: "Brom Castlewich",
        state: "Hamingber",
        postcode: "E63 9YD",
        country: "United Kingdom",
        telephone: "012 345 6789",
        email: "testuser@adlab.co.uk"
    )
    
    static var fromAddress = Address(
        street: "24 East Avenue",
        city: "Rakusa",
        state: "Gichito",
        postcode: "123-4567",
        country: "Japan",
        telephone: "012 345 6789",
        email: "testuser@adlab.co.uk"
    )
    
    static var package = Package(
        toAddress: toAddress,
        fromAddress: fromAddress
    )
    
    static var previews: some View {
        Form {
            PackageLabelMiniPreview(package: package)
        }
    }
}
