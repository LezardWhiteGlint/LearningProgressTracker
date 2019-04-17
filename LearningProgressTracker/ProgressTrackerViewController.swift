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
    var data = [Lecture]()
    var context = AppDelegate.viewContext
    
    @IBOutlet weak var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        data = loadData()
        tableView.reloadData()
        
    }
    
    
    //MARK: -Actions
    @IBAction func addRow(_ sender: NSButtonCell) {
        //        let entity = NSEntityDescription.entity(forEntityName: "Lecture", in: context)
        //        let newLecture = NSManagedObject(entity: entity!, insertInto: context) as? Lecture
        //        newLecture?.lecture = "test"
        let newLecture = Lecture(context: context)
        newLecture.finish = 0
        do {
            try context.save()
        } catch {
            print("save failed")
        }
        data.append(newLecture)
        tableView.reloadData()
    }
    
    @IBAction func lectureEndEditing(_ sender: NSTextField) {
        let selectedRow = tableView.selectedRow
        data[selectedRow].lecture = sender.stringValue
        try? context.save()
    }
    @IBAction func reminderEndEditing(_ sender: NSTextField) {
        let selectedRow = tableView.selectedRow
        data[selectedRow].reminder = sender.stringValue
        try? context.save()
    }

    
    @objc func checkBox(_ sender:NSButton) {
        let selectedRow = sender.tag
        print(selectedRow)
        data[selectedRow].finish = Int16(sender.state.rawValue)
        if sender.state.rawValue == 1{
            data[selectedRow].finishDate = Date().description(with: .current)
        }else{
            data[selectedRow].finishDate = nil
        }
        try? context.save()
        tableView.reloadData()
    }
    
    @IBAction func deleteRow(_ sender: NSButton) {
        if data.count != 0 {
            context.delete(data.last!)
            try? context.save()
        }
        data = loadData()
        tableView.reloadData()
    }
    
    

    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    private func loadData() -> [Lecture]{
        var lectures = [Lecture]()
        let request: NSFetchRequest<Lecture> = Lecture.fetchRequest()
        //    request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
        //        request.predicate = NSPredicate(format: "amount > %@", "0")
        //        let context = AppDelegate.viewContext
        let result = try? context.fetch(request)
        for lecture in (result ?? []){
            lectures.append(lecture)
        }
        return lectures
    }
    
    
    
    
    
}




extension ProgressTrackerViewController:NSTableViewDelegate{
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        switch tableColumn?.identifier {
        case NSUserInterfaceItemIdentifier(rawValue: "Lecture"):
            let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "Lecture"), owner: nil) as? NSTableCellView
            cell?.textField?.stringValue = data[row].lecture ?? ""
            return cell
        case NSUserInterfaceItemIdentifier(rawValue: "FinishDate"):
            let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "FinishDate"), owner: nil) as? NSTableCellView
            cell?.textField?.stringValue = data[row].finishDate ?? ""
            return cell
        case NSUserInterfaceItemIdentifier(rawValue: "Reminder"):
            let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "Reminder"), owner: nil) as? NSTableCellView
            cell?.textField?.stringValue = data[row].reminder ?? ""
            return cell
        case NSUserInterfaceItemIdentifier(rawValue: "Finish"):
            let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "Finish"), owner: nil) as? NSTableCellView
            let button = NSButton()
            button.setButtonType(.switch)
            button.title = ""
            button.target = self
            button.action = #selector(checkBox)
            button.tag = row
            button.state = NSControl.StateValue(rawValue: Int(data[row].finish))
            cell?.addSubview(button)
            return button
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


