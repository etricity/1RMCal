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
    @IBOutlet weak var history: UITableView!
    
    var exerciseManager : ExerciseManager!
    // Model Data
    var numCells : Int {
        return exerciseManager.exercise.instances?.count ?? 0
    }
    
    var segueForward : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Delegation
        self.history.delegate = self
        self.history.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initView()
        self.segueForward = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if !segueForward {
            NotificationCenter.default.post(name: .saveData, object: nil, userInfo: nil)
        }
    }
    
    func initView() {
        self.title = exerciseManager.exercise.name
        history.tableFooterView = UIView()
        current1RM.text = exerciseManager.exercise.bestSet?.summary ?? "N/A"
    }
    
    
    // TableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseHistoryCell", for: indexPath) as! LabelCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        // print exercise instances in reverse
        let index = exerciseManager.numInstances - 1 - indexPath.row
        if let instance : ExerciseInstance = exerciseManager.getInstance(index: index) {
            cell.label.text = "Max 1RM: " + (instance.bestSet?.summary ?? "") + "   " + dateFormatter.string(from: instance.date)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    // Delete table cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            
            if exerciseManager.removeInstance(index: indexPath.row) {
                current1RM.text = exerciseManager.exercise.bestSet?.summary
                history.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        performSegue(withIdentifier: "viewHistory", sender: index)
        
    }
    
    func createInstance(name : String, sets : [SetStat]) {
        // self.exercise is automatically updated when core data is saved
        let instance = exerciseManager.createInstance(name: name, sets: sets)
        history.reloadData()
    }
    
    // Segue Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        self.segueForward = true
        
        switch segue.identifier {
        case "newInstance":
            let vc = segue.destination as? ExerciseInstanceViewController
            vc?.title = self.title
            vc?.bestSetText = self.current1RM.text ?? "N/A"
            vc?.parentVC = self
            vc?.setsManager = SetStatManager()
        case "viewHistory":
            let index = sender as! Int
            let vc = segue.destination as? SetHistoryViewController
            vc?.title = self.title
            
            if let instance = exerciseManager.getInstance(index: index),
               let set : [SetStat] = instance.sets.array as? [SetStat] {
                vc?.setsManager = SetStatManager(sets: set)
            }
        default:
            break
        }
    }
}
