//
//  ExerciseTVDelegate.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 23/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

// The ExerciseTableViewManager acts as thhe delegate & data source for any table cell showing exercises in a table view

class ExerciseTableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as! LabelCell
        cell.label.text = vm.getExercises()[indexPath.row].name
        return cell
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

// The ExerciseTMVPlus acts as a ExerciseTableViewManager with additional functionality (eg. doing something on selection)

class ExerciseTMVPlus : ExerciseTableViewManager {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath) as! LabelCell
        
        // add exercise to workout layout
        if selectedCell.selectionStyle != .none {
            selectedCell.label.textColor = .gray
            selectedCell.selectionStyle = .none
        }
        let data : [String : Int] = ["index" : indexPath.row]
        NotificationCenter.default.post(name: .addExerciseToWorkout, object: nil, userInfo: data)
    }

}
