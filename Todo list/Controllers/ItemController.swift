//
//  ItemController.swift
//  Todo list
//
//  Created by Jack on 20/6/20.
//  Copyright © 2020 Jack. All rights reserved.
//

import Foundation
import UIKit
import SwipeCellKit

class ItemController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
    //
    //    }
    
    var itemGroup: ItemGroup?
    
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        self.title = itemGroup?.name;
        super.viewDidLoad();
        tblView.dataSource = self;
        tblView.delegate = self;
        
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new", message: "Add a new Item", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your Item name";
        }
        
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { action in
        }))
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            if let data = alert.textFields?.first?.text {
                if (data == "") {
                    return ;
                }
                let item: Item = Item(value: ["name": data]);
                store.dispatch(updateTodoListAction(group: self.itemGroup!, item: item));
            
                self.tblView.reloadData();
            }
        }))
        
        self.present(alert, animated: true, completion: nil);
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true);
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemGroup?.items.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "todoItem", for: indexPath) ;
        
        cell.textLabel?.text = itemGroup?.items[indexPath.row].name;
        
        //cell.delegate = self;
        
        return cell;
    }
}
