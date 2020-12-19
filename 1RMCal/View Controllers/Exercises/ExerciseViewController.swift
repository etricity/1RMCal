//
//  ExerciseViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 18/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    //View connections
    @IBOutlet weak var current1RM: UILabel!
    @IBOutlet weak var next1RM: UILabel!
    @IBOutlet weak var history: UITableView!
    
    // Model Data
    var exercise : Exercise? 
    
    //History Data
    var historyData : [String] = ["15/10    133kg     100kgx10", "15/10    133kg     100kgx10", "15/10    133kg     100kgx10"]
    var numCells : Int {
        return historyData.count
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = exercise?.name
        
        //Delegation
        self.history.delegate = self
        self.history.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    
    // TableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseHistoryCell", for: indexPath) as! ExerciseTableViewCell
        
        cell.label.text = historyData[indexPath.row]

        return cell
    }
    
     func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            historyData.remove(at: indexPath.row)
            history.reloadData()
            
            //Erase from core data
        }
    }

    
    //Segue Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
            if segue.destination is CalViewController
            {
                let vc = segue.destination as? CalViewController
                vc?.title = self.title
            }
        }
}
