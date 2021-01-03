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
    
    var parentVC : (UIViewController & ExerciseInstanceCreator)!
    @IBOutlet weak var current1RM: UILabel!
    var bestSetText : String = ""
    
    var instance : ExerciseInstance!
    
    
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
        self.current1RM.text = bestSetText
        setsTableView.tableFooterView = UIView()
    }
    
    // Button Actions
    
    // Finised performing exercise
    @IBAction func finishExercise(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        // ensures instance is only added if a set if performed
        if !instance.sets.isEmpty {
            parentVC.addInstance(newInstance: instance)
        }
    }
    
    
    // TableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numSets = instance.sets.count
        numSets += 1
        return numSets
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "setCell", for: indexPath) as! LabelCell
        cell.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        
        if instance.sets.indices.contains(indexPath.row) {
            let setStat : SetStat = instance.sets[indexPath.row]
            cell.label.text = setStat.summary
            cell.label.textColor = .white
        } else {
            cell.label.text = "Perform Set"
        }
        return cell
    }
    
    
    // Perform a set
    func addSet(newSet : SetStat) {
        instance.addSet(newSet: newSet)
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
