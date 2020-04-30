//
//  PDFViewController.swift
//  AdLab
//
//  Created by David Somen on 29/04/2020.
//  Copyright © 2020 David Somen. All rights reserved.
//

import SwiftUI
import PDFKit

struct PDFViewer: UIViewRepresentable {
    var url: URL
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.displayMode = .singlePageContinuous
        pdfView.autoScales = true
        
        if let pdfDocument = PDFDocument(url: url) {
            pdfView.document = pdfDocument
        }
        
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {}
}
