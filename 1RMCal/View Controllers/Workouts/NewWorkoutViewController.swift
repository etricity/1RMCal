//
//  NewWorkoutViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 23/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class NewWorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutLayoutCell", for: indexPath) as! ExerciseTableViewCell
        cell.label.text = "Cell \(indexPath.row)"
        return cell
   }
    

    
    @IBOutlet weak var exercisesTableView: UITableView!
    @IBOutlet weak var workoutLayout: UITableView!
    
    var dataSource = ExerciseTVDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exercisesTableView.dataSource = dataSource
        exercisesTableView.tableFooterView = UIView()
        
        workoutLayout.delegate = self
        workoutLayout.dataSource = self
        workoutLayout.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
}
