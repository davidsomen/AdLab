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

struct AddressTextFields: View {
    @Binding var address: Address
    
    var body: some View {
        Group() {
            TextField("Street", text: $address.street).autocapitalization(.words)
            TextField("City", text: $address.city).autocapitalization(.words)
            TextField("State", text: $address.state).autocapitalization(.words)
            TextField("Post Code", text: $address.postcode).autocapitalization(.words)
            TextField("Country", text: $address.country).autocapitalization(.allCharacters)
        }
    }
}

struct ContactTextFields: View {
    @Binding var address: Address
    
    var body: some View {
        Group() {
            TextField("Telephone", text: $address.telephone).keyboardType(.numberPad)
            TextField("Email", text: $address.email).keyboardType(.emailAddress).autocapitalization(.none)
        }
    }
}

struct ReturnAddressForm: View {
    @Binding var address: Address
    @Binding var isActive: Bool
    
    var body: some View {
        Form {
            Section() {
                AddressTextFields(address: $address)
            }
            Section() {
                ContactTextFields(address: $address)
            }
        }.navigationBarTitle("Return Address", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing: Button("Save") {
                self.isActive = false
            })
    }
}

struct PDFModal: View {
    var body: some View {
        Text("PDF")
    }
}

struct PackageForm: View {
    @State private var package = Package()
    @State private var showReturnAddressForm = false
    @State private var showPDFModal = false
    
    var body: some View {
        Form {
            Section {
                NavigationLink(destination:
                ReturnAddressForm(address: $package.fromAddress, isActive: $showReturnAddressForm), isActive: $showReturnAddressForm) {
                    Text("Return Address").lineLimit(1).layoutPriority(1)
                    Spacer()
                    Text(package.fromAddress.street).foregroundColor(.gray).lineLimit(1).minimumScaleFactor(0.8)
                }
                
            }
            Section(header: Text("Receipt Address")) {
                AddressTextFields(address: $package.toAddress)
            }
            Section() {
                ContactTextFields(address: $package.toAddress)
            }
            Section(header: Text("Postage")) {
                Picker("Postage Type", selection: $package.postageType) {
                    Text("AIRMAIL").tag(PostageType.airmail)
                    Text("SAL").tag(PostageType.sal)
                }.pickerStyle(SegmentedPickerStyle())
                Toggle(isOn: $package.isSmallPacket.animation()) {
                    Text("Small Packet")
                }
            }
            
            Section(header: Text("Preview")) {
                PackageLabelMiniPreview(package: package)
            }
            
            Section(footer: Text(package.toAddress.isComplete ? "" : "Please fill in all fields.").foregroundColor(.red)) {
                Button("Generate PDF") {
                    self.showPDFModal = true
                }.sheet(isPresented: $showPDFModal) {
                    PDFModal()
                }
            }.disabled(!package.toAddress.isComplete)
        }.navigationBarTitle("AdLab").navigationBarItems(trailing: Button(action: {}) {
            Text("Fill")
        })
    }
}

struct PackageLabelPreview: View {
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
                            Text(package.fromAddress.fullAddress)
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
                            Text(package.postageType.rawValue)
                                .font(.title)
                                .fontWeight(.bold)
                                .minimumScaleFactor(0.5)
                                .padding(5)
                            Divider().frame(height: 1).background(Color.black)
                        },
                        alignment: .topTrailing)
            }.frame(height: 150)
            Divider().frame(height: 1).background(Color.black)
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
            .frame(width: PackageLabelPreview.RENDER_SIZE.width,
                   height: PackageLabelPreview.RENDER_SIZE.height)
    }
}

struct PackageLabelMiniPreview: View {
    var package: Package
    
    var body: some View {
        let SCALE: CGFloat = 0.6
        let height = PackageLabelPreview.RENDER_SIZE.height * SCALE
        
        return GeometryReader { proxy in
            PackageLabelPreview(package: self.package)
                .scaleEffect(SCALE)
                .frame(width: proxy.size.width, height: height)
        }.frame(height: height)
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
