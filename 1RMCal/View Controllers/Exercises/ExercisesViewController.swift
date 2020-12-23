//
//  ExercisesViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 13/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class ExercisesViewController: UITableViewController, UIActionSheetDelegate {
    
    @IBOutlet var exercisesTableView: UITableView!
    
    var dataSource = ExerciseTVDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        exercisesTableView.dataSource = dataSource
        exercisesTableView.tableFooterView = UIView()
    }
    
    //Adding new exercise to table view
    @IBAction func addExercise(_ sender: Any) {
        // Alert configuration
        let alert = UIAlertController(title: "New Exercise", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Exercise Name"
        }
        
        
        //confirm new exercise
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            // add exercise to tableview
            if let newExercise = alert.textFields![0].text {
                //add exercise
                if self.dataSource.vm.addExercise(name: newExercise) {
                    self.tableView.reloadData()
                } else {
                    print("DUPLICATE")
                }
            }
        } ))
        
        // cancel action
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //Segue Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if let  exercise = sender as? ExerciseTableViewCell {
            if segue.destination is ExerciseViewController
            {
                let vc = segue.destination as? ExerciseViewController
                vc?.exercise = dataSource.vm.getExercise(name: exercise.label.text!)
            }
        }

    }

}
