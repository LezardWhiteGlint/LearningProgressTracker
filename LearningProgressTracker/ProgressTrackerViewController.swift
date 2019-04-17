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
    var data = [Lecture]()
    var context = AppDelegate.viewContext
    
    @IBOutlet weak var tableView: NSTableView!
    @IBAction func test(_ sender: NSButtonCell) {
//        let entity = NSEntityDescription.entity(forEntityName: "Lecture", in: context)
//        let newLecture = NSManagedObject(entity: entity!, insertInto: context) as? Lecture
//        newLecture?.lecture = "test"
        let newLecture = Lecture(context: context)
        do {
          try context.save()
        } catch {
            print("save failed")
        }
        data.append(newLecture)
        tableView.reloadData()
    }
    @IBOutlet weak var check: NSButtonCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
