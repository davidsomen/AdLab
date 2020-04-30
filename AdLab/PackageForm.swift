//
//  PackageForm.swift
//  AdLab
//
//  Created by David Somen on 30/04/2020.
//  Copyright © 2020 David Somen. All rights reserved.
//

import SwiftUI

struct AddressTextFields: View {
    @Binding var address: Address
    
    var body: some View {
        Group() {
            TextField("Street", text: $address.street).autocapitalization(.words)
            TextField("City", text: $address.city).autocapitalization(.words)
            TextField("State", text: $address.state).autocapitalization(.words)
            TextField("Post Code", text: $address.postcode).autocapitalization(.allCharacters)
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
            .navigationBarItems(trailing: Button("Done") {
                self.isActive = false
            })
    }
}

struct PDFModal: View {
    var url: URL
    
    @State private var showActivityView = false
    
    var body: some View {
        PDFViewer(url: url)
            .navigationBarTitle("Address Label", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.showActivityView = true
            }) {
                Image(systemName: "square.and.arrow.up").font(.largeTitle)
            }.sheet(isPresented: self.$showActivityView) {
                ActivityView(activityItems: [self.url])
            })
    }
}

struct PackageLabelMiniPreview: View {
    var package: Package
    
    var body: some View {
        let SCALE: CGFloat = 0.6
        let height = PackageLabelView.RENDER_SIZE.height * SCALE
        
        return GeometryReader { proxy in
            PackageLabelView(package: self.package)
                .scaleEffect(SCALE)
                .frame(width: proxy.size.width, height: height)
        }.frame(height: height)
    }
}

struct PackageForm: View {
    @State private var package = Package()
    @State private var showReturnAddressForm = false
    @State private var showPDFModal = false
    
    @State private var pdfURL: URL?
    
    var body: some View {
        Form {
            Section {
                NavigationLink(destination:
                ReturnAddressForm(address: $package.fromAddress, isActive: $showReturnAddressForm), isActive: $showReturnAddressForm) {
                    Text("Return Address")
                        .lineLimit(1)
                        .layoutPriority(1)
                    Spacer()
                    Text(package.fromAddress.street)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }
                
            }
            Section(header: Text("Receipt Address")) {
                AddressTextFields(address: $package.toAddress)
            }
            Section() {
                ContactTextFields(address: $package.toAddress)
            }
            Section(header: Text("Postage")) {
                Toggle(isOn: $package.isSmallPacket.animation()) {
                    Text("Small Packet")
                }
                Picker("Postage Type", selection: $package.postageType) {
                    Text("AIRMAIL").tag(PostageType.airmail)
                    Text("SAL").tag(PostageType.sal)
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Preview")) {
                PackageLabelMiniPreview(package: package).padding()
            }
            
            Section(footer: Text(package.toAddress.isComplete ? "" : "Please fill in all fields.").foregroundColor(.red)) {
                Button("Create PDF") {
                    self.pdfURL = PackageLabelView(package: self.package).exportTempPDF(size: PackageLabelView.RENDER_SIZE)
                    
                    self.showPDFModal = true
                }.sheet(isPresented: $showPDFModal) {
                    NavigationView {
                        PDFModal(url: self.pdfURL!)
                    }
                }
            }//.disabled(!package.toAddress.isComplete)
        }.navigationBarTitle("AdLab")
    }
}

#if DEBUG

struct PackageForm_Previews: PreviewProvider {
    static var previews: some View {
        PackageForm()
    }
}

struct PDFModal_Previews: PreviewProvider {
    static private var pdfURL: URL {
        let path = Bundle.main.path(forResource: "TestPackage", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let package = try! JSONDecoder().decode(Package.self, from: data)
        return PackageLabelView(package: package).exportTempPDF(size: PackageLabelView.RENDER_SIZE)
    }
    
    static var previews: some View {
        return PDFModal(url: pdfURL)
    }
}

#endif
