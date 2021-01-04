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
    
    lazy var exerciseInstanceManager = ExerciseInstanceManager(exercise: exercise)
    // Model Data
    var exercise : Exercise!
    var numCells : Int {
        return exercise.instances?.count ?? 0
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
        self.title = exercise.name
        history.tableFooterView = UIView()
        current1RM.text = exercise.bestSet?.summary ?? "N/A"
    }
    
    
    // TableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseHistoryCell", for: indexPath) as! LabelCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        if let instance : ExerciseInstance = exercise.getInstance(index: indexPath.row) {
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
            
            if exerciseInstanceManager.removeInstance(index: indexPath.row) {
                current1RM.text = exercise.bestSet?.summary
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
        let instance = exerciseInstanceManager.createInstance(name: name, sets: sets)
        history.reloadData()
    }
    
//    // Perform exercise
//    func addInstance(newInstance : ExerciseInstance) {
//        exercise.addInstance(instance: newInstance)
//        history.reloadData()
//    }
    
    // Segue Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        self.segueForward = true
        
        switch segue.identifier {
        case "newInstance":
            let vc = segue.destination as? ExerciseInstanceViewController
            vc?.title = self.title
            vc?.bestSetText = self.current1RM.text ?? "N/A"
//            vc?.exerciseInstance = ExerciseInstance(name: exercise.name)
            vc?.parentVC = self
        case "viewHistory":
            let index = sender as! Int
            let vc = segue.destination as? SetHistoryViewController
            vc?.title = self.title
//            vc?.exerciseInstance = exercise.instances[index]
        default:
            break
        }
    }
}
