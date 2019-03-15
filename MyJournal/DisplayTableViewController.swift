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
        
        cell.textLabel?.text = items.reversed()[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
        
    }
}

