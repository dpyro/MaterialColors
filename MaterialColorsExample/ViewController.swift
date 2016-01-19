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
    let colors: [MaterialColor] = MaterialColors.colorGroups.flatMap { $0.map { $0 } }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITableViewController
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let materialColor = colors[indexPath.row]
        
        cell.textLabel?.text = materialColor.name
        cell.textLabel?.textColor = materialColor.textColor
        cell.backgroundColor = colors[indexPath.row].color
        
        return cell
    }
}

