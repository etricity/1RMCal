//
//  ExerciseTVDelegate.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 23/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class ExerciseTVDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var vm : ExerciseViewModel = ExerciseViewModel()

    
    var numCells : Int {
        return vm.getExercises().count
    }
    
    // MARK: - Table view data source
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numCells
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as! ExerciseTableViewCell
        cell.label.text = vm.getExercises()[indexPath.row].name
        return cell
    }
    
     func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            vm.removeExercise(index: indexPath.row)
            tableView.reloadData()
            
            //Erase from Core Data
        }
     }
}
