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
    var exercise : Exercise!
    
    //History Data
    var numCells : Int {
        return exercise.instances.count
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
        return exercise.instances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseHistoryCell", for: indexPath) as! ExerciseTableViewCell
        
        // change later to best set stats
        cell.label.text = exercise.instances[indexPath.row].sets.first?.toString()

        return cell
    }
    
     func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            exercise.instances.remove(at: indexPath.row)
            history.reloadData()
            
            //Erase from core data
        }
    }
    
    // Other functions
    func addInstance(newInstance : ExerciseInstance) {
        exercise?.instances.append(newInstance)
        history.reloadData()
    }
    
    //Segue Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is ExerciseInstanceViewController {
            let vc = segue.destination as? ExerciseInstanceViewController
            vc?.title = self.title
            vc?.exerciseVC = self
        }
    }
}
