//
//  PDFMaker.swift
//  AdLab
//
//  Created by David Somen on 29/04/2020.
//  Copyright © 2020 David Somen. All rights reserved.
//

import SwiftUI
import PDFKit

extension View {
    func exportTempPDF(size: CGSize) -> URL {
        let pdfVC = UIHostingController(rootView: self)
        pdfVC.view.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        let rootVC = UIApplication.shared.windows.first?.rootViewController
        rootVC?.addChild(pdfVC)
        rootVC?.view.insertSubview(pdfVC.view, at: 0)
        
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: -10, y: 0, width: size.width + 20, height: size.height + 20))
        
        let pdfData = pdfRenderer.pdfData() { context in
            context.beginPage()
            pdfVC.view.layer.render(in: context.cgContext)
        }
        
        pdfVC.removeFromParent()
        pdfVC.view.removeFromSuperview()
        
        let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("AddressLabel.pdf")
        try! pdfData.write(to: fileURL, options: .atomic)
        
        return fileURL
    }
}
