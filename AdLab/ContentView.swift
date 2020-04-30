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

#if DEBUG

struct ConectView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()//.previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
    }
}

#endif
