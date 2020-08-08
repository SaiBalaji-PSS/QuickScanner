//
//  PreviewVC.swift
//  QuickScanner
//
//  Created by Sai Balaji on 08/08/20.
//  Copyright © 2020 Sai Balaji. All rights reserved.
//

import UIKit
import PDFKit

class PreviewVC: UIViewController {

    
    var filePath: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(filePath!)
        
      
        
        
        let pdfView = PDFView()

        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)

        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        
        if let pdfdoc = PDFDocument(url: URL(string: filePath)!)
        {
            pdfView.document = pdfdoc
        }
        
       
        
    }
    

   

}
