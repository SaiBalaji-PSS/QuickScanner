//
//  DocumentCell.swift
//  QuickScanner
//
//  Created by Sai Balaji on 05/08/20.
//  Copyright © 2020 Sai Balaji. All rights reserved.
//

import UIKit

class DocumentCell: UICollectionViewCell {
    
    @IBOutlet weak var documentthumbnail: UIImageView!
    
    @IBOutlet weak var tname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    
    func updateCell(timage: UIImage,tname: String)
    {
        self.documentthumbnail.image = timage
        self.tname.text = tname
    }
    
    
}
