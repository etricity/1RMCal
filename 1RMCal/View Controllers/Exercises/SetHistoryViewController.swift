//
//  SetHistoryViewController.swift
//  1RMCal
//
//  Created by Isaiah Cuzzupe on 26/12/20.
//  Copyright © 2020 Isaiah Cuzzupe. All rights reserved.
//

import UIKit

class SetHistoryViewController: UITableViewController {

    var setsManager : SetStatManager!
    var sets : [SetStat] {
        return setsManager.sets
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Delegation
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // configure table view
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
    }
    
    
    // TableView functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {  
        return sets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "setHistoryCell", for: indexPath) as! LabelCell
        cell.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        
        if let setStat : SetStat = setsManager.getSet(index: indexPath.row) {
            cell.label.text = setStat.summary
            cell.label.textColor = .gray
        }
        return cell
    }
}
