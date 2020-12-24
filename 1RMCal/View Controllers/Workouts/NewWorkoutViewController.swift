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
    
    var vm : ExerciseViewModel = ExerciseViewModel()
    lazy var dataSource = ExerciseTableViewManager(data: vm.getExercises())
    
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
    
    @IBAction func newExercise(_ sender: Any) {
        
        //confirm new exercise
        let alert = UIAlertController(title: "New Exercise", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Exercise Name"
        }
        
        
        //confirm new exercise
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            // add exercise to tableview
            if let newExercise = alert.textFields![0].text {
                //add exercise
                if self.vm.addExercise(name: newExercise) {
                    // update exercise table
                    self.dataSource.addNewData(data: newExercise)
                    self.exercisesTableView.reloadData()
                } else {
                    print("DUPLICATE")
                }
            }
        } ))
        // cancel action
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @objc func addExerciseToWorkout(_ notification:Notification) {
        print("working")
        let index = notification.userInfo?["index"] as! Int
        workout.addExercise(exercise: vm.getExercises()[index])
        workoutLayout.reloadData()
    }
    
}
