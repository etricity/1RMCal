//
//  ExerciseInstanceViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 19/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class ExerciseInstanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var setsTableView: UITableView!
    
    //History Data
    var exerciseInstance : ExerciseInstance = ExerciseInstance()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        self.setsTableView.delegate = self
        self.setsTableView.dataSource = self
        setsTableView.tableFooterView = UIView()
    }
    
    
    // TableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numSets = exerciseInstance.sets.count
        
        if (numSets == 0) {
            numSets = 1
        }
        return numSets
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "setCell", for: indexPath) as! ExerciseTableViewCell
        cell.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        cell.label.text = "Perform Set"

        return cell
    }
}
