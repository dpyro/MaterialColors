//
//  ViewController.swift
//  MaterialColorsExample
//
//  Created by Sumant Manne on 1/18/16.
//  Copyright © 2016 Sumant Manne. All rights reserved.
//

import UIKit
import MaterialColors

class ViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITableViewController
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return MaterialColors.colorGroups.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return MaterialColors.colorGroups[section].name
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MaterialColors.colorGroups[section].count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let materialColor = MaterialColors.colorGroups[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = materialColor.name
        cell.textLabel?.textColor = materialColor.textColor
        cell.backgroundColor = materialColor.color
        
        return cell
    }
}

