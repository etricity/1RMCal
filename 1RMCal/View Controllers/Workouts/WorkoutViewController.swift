//
//  WorkoutViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 28/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController {

    @IBOutlet weak var workoutLayout: UITableView!
    @IBOutlet weak var history: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workoutLayout.tableFooterView = UIView()
        history.tableFooterView = UIView()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
