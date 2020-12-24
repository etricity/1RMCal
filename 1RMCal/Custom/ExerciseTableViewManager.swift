//
//  ExerciseTVDelegate.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 23/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

// The ExerciseTableViewManager acts as the delegate & data source for Exercise Table View on the workout creation page
/*
 Allows for:
    - viewing exercises
    - adding to exercises
 NOT ALLOWED:
    - deleting exercises
 */

class ExerciseTableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var data : [String] = []
    
    init(data : [Exercise]) {
        for exercise in data {
            self.data.append(exercise.name)
        }
    }
    
    var numCells : Int {
        return data.count
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
        cell.label.text = data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath) as! LabelCell
        
        // add exercise to workout layout
        if selectedCell.selectionStyle != .none {
            selectedCell.label.textColor = .gray
            selectedCell.selectionStyle = .none
            let data : [String : Int] = ["index" : indexPath.row]
            NotificationCenter.default.post(name: .addExerciseToWorkout, object: nil, userInfo: data)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func addNewData(data : String) {
        self.data.append(data)
    }
}
