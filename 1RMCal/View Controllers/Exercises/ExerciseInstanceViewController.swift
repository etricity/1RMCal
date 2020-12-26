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
    
    var exerciseVC : ExerciseViewController!
    
    //History Data
    var exerciseInstance : ExerciseInstance = ExerciseInstance()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Delegation
        self.setsTableView.delegate = self
        self.setsTableView.dataSource = self
        
        // Configure view on load
        initView()
    }
    
    func initView() {
        self.navigationController!.navigationBar.topItem!.title = "Cancel"
        setsTableView.tableFooterView = UIView()
    }
        
    // Finised performing exercise
    @IBAction func finishExercise(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        // ensures instance is only added if a set if performed
        if !exerciseInstance.sets.isEmpty {
            exerciseVC.addInstance(newInstance: exerciseInstance)
        }
    }
    
    
    // TableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numSets = exerciseInstance.sets.count
        // +1 for perform set cell
        numSets += 1
        return numSets
    }
    
    // Cell Configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "setCell", for: indexPath) as! LabelCell
        cell.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        
        if exerciseInstance.sets.indices.contains(indexPath.row) {
            let setStat : SetStat = exerciseInstance.sets[indexPath.row]
            cell.label.text = setStat.summary
            cell.label.textColor = .white
        } else {
            cell.label.text = "Perform Set"
        }
        return cell
    }
    
    
    // Perform a set
    func addSet(newSet : SetStat) {
        exerciseInstance.addSet(newSet: newSet)
        setsTableView.reloadData()
    }
    
    
    // Segue Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is CalViewController {
            let vc = segue.destination as? CalViewController
            vc?.exerciseVC = self   
        }
    }
}
