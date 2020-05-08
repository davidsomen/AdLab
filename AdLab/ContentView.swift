//
//  ContentView.swift
//  AdLab
//
//  Created by David Somen on 02/04/2020.
//  Copyright © 2020 David Somen. All rights reserved.
//

import SwiftUI

struct LogoView: View {
    @ObservedObject var logoViewModel: LogoViewModel
    
    var body: some View {
        HStack(spacing: logoViewModel.spacing) {
            Text("Ad").font(.largeTitle).bold().foregroundColor(Color("Cardboard"))
            Text("Lab").font(.largeTitle).bold().offset(y: 5)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        TabView {
            NavigationView {
                OrdersList()
            }.tabItem {
                Text("Orders")
                Image(systemName: "doc.text.fill")
            }
            NavigationView {
                PackageForm(package: Package())
            }.tabItem {
                Text("Create")
                Image(systemName: "printer.fill")
            }
        }.overlay(
            VStack {
                LogoView(logoViewModel: viewModel.logoViewModel)
                Spacer()
            }
        )
    }
}

#if DEBUG

struct ConectView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ViewModel()).previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
    }
}

#endif
