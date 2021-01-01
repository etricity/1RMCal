//
//  ExerciseViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 18/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExerciseInstanceCreator {

    
    //View connections
    @IBOutlet weak var current1RM: UILabel!
    @IBOutlet weak var history: UITableView!
    
    // Model Data
    var exercise : Exercise!
    var numCells : Int {
        return exercise.instances.count
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Delegation
        self.history.delegate = self
        self.history.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initView()
    }
    
    func initView() {
        self.title = exercise.name
        history.tableFooterView = UIView()
        current1RM.text = exercise.bestSet?.summary ?? "N/A"
    }
    
    
    // TableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercise.instances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseHistoryCell", for: indexPath) as! LabelCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let instance = exercise.instances[indexPath.row]
        cell.label.text = "Max 1RM: " + (instance.bestSet?.summary ?? "") + "   " + dateFormatter.string(from: instance.date)

        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    // Delete table cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            exercise.removeInstance(index: indexPath.row)
            history.reloadData()
            
            //Erase from core data
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        performSegue(withIdentifier: "viewHistory", sender: index)
        
    }
    
    // Perform exercise
    func addInstance(newInstance : ExerciseInstance) {
        exercise.addInstance(newInstance: newInstance)
        history.reloadData()
    }
    
    // Segue Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "newInstance":
            let vc = segue.destination as? ExerciseInstanceViewController
            vc?.title = self.title
            vc?.bestSetText = self.current1RM.text ?? "N/A"
            vc?.exerciseInstance = ExerciseInstance(name: exercise.name)
            vc?.parentVC = self
        case "viewHistory":
            let index = sender as! Int
            let vc = segue.destination as? SetHistoryViewController
            vc?.title = self.title
            vc?.exerciseInstance = exercise.instances[index]
        default:
            break
        }
    }
}
