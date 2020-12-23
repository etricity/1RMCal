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
        return workout.exercises.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutLayoutCell", for: indexPath) as! LabelCell
        cell.label.text = workout.exercises[indexPath.row].name
        return cell
   }
    

    
    @IBOutlet weak var exercisesTableView: UITableView!
    @IBOutlet weak var workoutLayout: UITableView!
    
    var workout : Workout = Workout(test: false)
    
    var dataSource = ExerciseTMVPlus()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(addExerciseToWorkout(_:)), name: .addExerciseToWorkout, object: nil)
        
        exercisesTableView.delegate = dataSource
        exercisesTableView.dataSource = dataSource
        exercisesTableView.allowsSelectionDuringEditing = true
        exercisesTableView.tableFooterView = UIView()
        
        workoutLayout.delegate = self
        workoutLayout.dataSource = self
        workoutLayout.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
    
    @objc func addExerciseToWorkout(_ notification:Notification) {
        print("working")
        let index = notification.userInfo?["index"] as! Int
        workout.addExercise(exercise: dataSource.vm.getExercises()[index])
        workoutLayout.reloadData()
        
    }
    
}
