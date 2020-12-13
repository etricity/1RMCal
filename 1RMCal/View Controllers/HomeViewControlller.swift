//

//
//  ViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 30/11/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //Segue Buttons

    
    //Button Actions
    @IBAction func goToWorkouts(_ sender: Any) {
    }
    @IBAction func goToExercises(_ sender: Any) {
        performSegue(withIdentifier: "goToExercises", sender: self)
    }
    @IBAction func goToCalculator(_ sender: Any) {
        performSegue(withIdentifier: "goToCal", sender: self)
    }
    @IBAction func goToStats(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToExercises" {
            guard let vc = segue.destination as? CalViewController else { return }
        }
    }


}

