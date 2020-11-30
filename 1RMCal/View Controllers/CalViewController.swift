//
//  CalViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 30/11/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class CalViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    //View Connections
    @IBOutlet weak var setInfoStack: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegation
        self.setInfoStack.delegate = self
        self.setInfoStack.dataSource = self

        // Do any additional setup after loading the view.
    }
}

extension CalViewController {
    //Num items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCollectionViewCell
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
    
    //Defines cell dimensions
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = collectionView.frame.size.width;
        let cellHeight = collectionView.frame.size.height;
        return CGSize(width: cellWidth, height: cellHeight / 3)
    }
}
