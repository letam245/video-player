//
//  DessertViewCell.swift
//  video-player
//
//  Created by Tammy Le on 10/30/18.
//  Copyright © 2018 Tammy Le. All rights reserved.
//

import UIKit

class DessertViewCell: UICollectionViewCell {
    
    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var Title: UILabel!
    
    
    var myDessert: Dessert!{
        
        didSet{
            updateData()
        }
    }
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected
            {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.contentView.backgroundColor = UIColor.red
               // print(myDessert.title)
            }
            else
            {
                self.transform = CGAffineTransform.identity
                self.contentView.backgroundColor = UIColor.gray
            }
        }
    }
    
    func updateData(){
        
        Title.text = myDessert.title
        Img.image = myDessert.images
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
}
