//
//  DetailViewController.swift
//  video-player
//
//  Created by Tammy Le on 10/30/18.
//  Copyright © 2018 Tammy Le. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var IMG: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    
    
    var name = ""
    var selectedDessertImg : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelName.text = name
        
        //IMG.image = selectedDessertImg

        // Do any additional setup after loading the view.
    }
    

}
