//
//  CollectionViewController.swift
//  video-player
//
//  Created by Tammy Le on 10/30/18.
//  Copyright © 2018 Tammy Le. All rights reserved.
//

import UIKit


class CollectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControll: UIPageControl!
    
    //var delegate: imageSelectionDelegate?
    
    var dessert = Dessert.createCategory()
    
    var selecT : Dessert?
    var categories = ["Real Estate Training Events","#TOMSVLOG"]
    
    
    var timer : Timer!
    var updateCount : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCount = 0
        timer = Timer.scheduledTimer(timeInterval: 2.5,target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc internal func updateTimer()
    {
        if(updateCount <= 2){
            pageControll.currentPage = updateCount
            imageView.image = UIImage(named: String(updateCount+1) + ".jpg")
            updateCount = updateCount + 1
        }
        else{
            updateCount = 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Tableview Delegate
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subClass") as! SubClass
        
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
}


extension CollectionViewController : imageSelectionDelegate {
    func didSelect() {
        
    }
    
    func didSelect(selDessert: Dessert, index: IndexPath) {
        performSegue(withIdentifier: "gotoDetail", sender: index)
        selecT = selDessert
        print(selecT!.images)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if( segue.identifier == "gotoDetail" ) {
            
            let detailVC = segue.destination as! DetailViewController
            if let indexPath = sender as? IndexPath {
                
                let dessertToTrasfer = dessert[indexPath.row]

                detailVC.name = dessertToTrasfer.title
                detailVC.selectedDessertImg = dessertToTrasfer.images
            }
        }
    }
    

}

