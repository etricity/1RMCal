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
    
    var setsManager : SetStatManager!
    var sets : [SetStat] {
        return setsManager.sets
    }
    var parentVC : ExerciseViewController!
    @IBOutlet weak var current1RM: UILabel!
    var bestSetText : String = ""
    
    // ExerciseInstance variables for creation
    var exerciseName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let exerciseName = self.title {
            self.exerciseName = exerciseName
        }
        
        // Delegation
        self.setsTableView.delegate = self
        self.setsTableView.dataSource = self
        
        // Configure view on load
        initView()
    }
    
    func initView() {
        self.navigationController!.navigationBar.topItem!.title = "Cancel"
        self.current1RM.text = bestSetText
        setsTableView.tableFooterView = UIView()
    }
    
    // Button Actions
    
    // Finised performing exercise
    @IBAction func finishExercise(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    
        if exerciseName.count > 0 && !sets.isEmpty {
            self.createExerciseInstance()
        }
    }
    
    // Finished performing exercise --> create instance
    func createExerciseInstance() {
        parentVC.createInstance(name : exerciseName, sets : sets)
    }
    
    
    // TableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numSets = sets.count
        numSets += 1
        return numSets
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "setCell", for: indexPath) as! LabelCell
        cell.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        
        if sets.indices.contains(indexPath.row) {
            let setStat : SetStat = sets[indexPath.row]
            cell.label.text = setStat.summary
            cell.label.textColor = .white
        } else {
            cell.label.text = "Perform Set"
        }
        return cell
    }
    
    // Performed set 
    func createSet(weight: Double, repCount: Double, unitString: String) {
        let newSet = setsManager.createSetStat(weight: weight, repCount: repCount, unitString: unitString)
        setsManager.addSet(set: newSet)
        setsTableView.reloadData()
    }
    
    
    // Segue Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is CalViewController {
            let vc = segue.destination as? CalViewController
            vc?.parentVC = self   
        }
    }
}
