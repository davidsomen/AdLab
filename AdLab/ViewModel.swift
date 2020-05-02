//
//  ViewModel.swift
//  AdLab
//
//  Created by David Somen on 02/05/2020.
//  Copyright © 2020 David Somen. All rights reserved.
//

import SwiftUI

class LogoViewModel: ObservableObject {
    @Published private(set) var spacing: CGFloat = 0

    var yScroll: CGFloat = 0 {
        didSet {
            spacing = yScroll - 160 > 0 ? yScroll - 160 : 0
        }
    }
}

class ViewModel: ObservableObject {
    var logoViewModel = LogoViewModel()
}
