//
//  ContentView.swift
//  AdLab
//
//  Created by David Somen on 02/04/2020.
//  Copyright © 2020 David Somen. All rights reserved.
//

import SwiftUI

struct AdLabLogo: View {
    var body: some View {
        HStack(spacing: 0) {
            Text("Ad").font(.largeTitle).bold().foregroundColor(Color("Cardboard"))
            Text("Lab").font(.largeTitle).bold().offset(y: 5)
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            PackageForm(package: Package())
        }.overlay(
            VStack {
                AdLabLogo()
                Spacer()
            }.navigationBarTitle("").navigationBarHidden(true)
        )
    }
}

#if DEBUG

struct ConectView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
    }
}

#endif
