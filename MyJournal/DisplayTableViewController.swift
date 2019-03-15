//
//  DisplayTableViewController.swift
//  MyJournal
//
//  Created by Kertu Kipper on 11/03/2019.
//  Copyright © 2019 Kertu Kipper. All rights reserved.
//

import UIKit

class DisplayTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "My Entries"
        
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    func fetchData() {
        
        do {
            items = try context.fetch(Item.fetchRequest())
            print(items)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Couldn't Fetch Data")
        }
        
    }
    
}


extension DisplayTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        let date = items.reversed()[indexPath.row].date
        let time = items.reversed()[indexPath.row].time
        
        cell.textLabel?.text = items.reversed()[indexPath.row].name
        
        if let date = date, let time = time {
            let timeStamp = "Added on \(date) at \(time)"
            cell.detailTextLabel?.text = timeStamp
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            
            let item = self.items[indexPath.row]
            self.context.delete(item)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            self.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
        delete.backgroundColor = UIColor(red: 193/255, green: 21/255, blue: 148/255, alpha: 1.0)
        
        return [delete]
        
    }
}

