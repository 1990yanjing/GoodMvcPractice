//
//  ToDoListTableViewController.swift
//  ToDoMVC
//
//  Created by wangyan on 2018/5/29.
//  Copyright © 2018年 wangyan. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ToDoStore.shared.getAlItems()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(todoItemsDidChange),
            name: NSNotification.Name(rawValue: "toDoStoreDidChangedNotification"),
            object: nil)
    }
    
    @IBAction func pressAddButton(_ sender: UIBarButtonItem) {
        
        ToDoStore.shared.append(item: ToDoItem(title: "title\(ToDoStore.shared.count + 1)"))
    }
    
    @objc func todoItemsDidChange(_ notification: Notification) {
        
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ToDoStore.shared.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = ToDoStore.shared.item(at: indexPath.row).title
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "删除") { _, _, done in
            
            ToDoStore.shared.remove(at: indexPath.row)
            done(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
