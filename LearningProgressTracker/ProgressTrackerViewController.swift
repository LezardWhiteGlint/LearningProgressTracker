//
//  ViewController.swift
//  LearningProgressTracker
//
//  Created by Lezardvaleth on 2019/4/16.
//  Copyright © 2019 Lezardvaleth. All rights reserved.
//

import Cocoa

class ProgressTrackerViewController: NSViewController {
    //MARK: -Properties
    struct Class {
        var lecture:String
        var finishDate:Date?
        var 
    }
    
    @IBOutlet weak var tableView: NSTableView!
    @IBAction func test(_ sender: NSButtonCell) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


extension ProgressTrackerViewController:NSTableViewDelegate{
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        switch tableColumn?.identifier {
        case NSUserInterfaceItemIdentifier(rawValue: "Lecture"):
            let cell = NSTextField()
            cell.identifier = NSUserInterfaceItemIdentifier(rawValue: "Lecture")
            cell.stringValue = classes[row]
            return cell
        default:
            return nil
        }
        
    }

}

extension ProgressTrackerViewController:NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return classes.count
    }
}
