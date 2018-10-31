//
//  SubClass.swift
//  video-player
//
//  Created by Tammy Le on 10/30/18.
//  Copyright © 2018 Tammy Le. All rights reserved.
//

import UIKit

protocol imageSelectionDelegate: class {
    func didSelect()
}

class SubClass: UITableViewCell {
    
    var delegate: imageSelectionDelegate?
    var dessert = Dessert.createCategory()
    var selectedDessrt = ""
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
       
    }
    

}

extension SubClass: UICollectionViewDataSource,UICollectionViewDelegate {
    //MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dessert.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dessertCell", for: indexPath) as! DessertViewCell
        
        myCell.myDessert = dessert[indexPath.row]
        
        return myCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       selectedDessrt = dessert[indexPath.row].title
       delegate?.didSelect()

    }
 
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if( segue.identifier == "gotoDetail" ) {
            
            let detailVC = segue.destination as! DetailViewController
            if let indexPath = sender as? IndexPath {
                
                let productToGet = dessert[indexPath.row]
                detailVC.name = productToGet.title
                print(productToGet.title)
            }
        }
    }

}

