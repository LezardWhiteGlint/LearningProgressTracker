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
        var lecture:String?
        var finishDate:String?
        var reminder:String?
        var finish:Bool
    }
    var data = [Class]()
    
    @IBOutlet weak var tableView: NSTableView!
    @IBAction func test(_ sender: NSButtonCell) {
        
    }
    @IBOutlet weak var check: NSButtonCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let data1 = Class(lecture: "test1", finishDate: nil, reminder: nil, finish: false)
        let data2 = Class(lecture: "test2", finishDate: Date().description, reminder: "time", finish: true)
        data = [data1,data2]
        tableView.reloadData()
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
                cell.stringValue = data[row].lecture ?? ""
                return cell
            case NSUserInterfaceItemIdentifier(rawValue: "FinishDate"):
                let cell = NSTextField()
                cell.identifier = NSUserInterfaceItemIdentifier(rawValue: "FinishDate")
                cell.stringValue = data[row].finishDate ?? ""
                return cell
            case NSUserInterfaceItemIdentifier(rawValue: "Reminder"):
                let cell = NSTextField()
                cell.identifier = NSUserInterfaceItemIdentifier(rawValue: "Reminder")
                cell.stringValue = data[row].reminder ?? ""
                return cell
            case NSUserInterfaceItemIdentifier(rawValue: "Finish"):
                let cell = NSButton()
                cell.setButtonType(.switch)
                cell.title = ""
                return cell
            default:
                return nil
            }
    
        }
    

}
    extension ProgressTrackerViewController:NSTableViewDataSource{
        func numberOfRows(in tableView: NSTableView) -> Int {
            return data.count
        }
    }
