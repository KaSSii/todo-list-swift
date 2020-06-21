//
//  ViewController.swift
//  Todo list
//
//  Created by Jack on 19/6/20.
//  Copyright © 2020 Jack. All rights reserved.
//

import UIKit
import Foundation;
import ReSwift
import SwipeCellKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    var itemGroups: [ItemGroup] = []
    
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Todo Today";
        tblView.delegate = self
        tblView.dataSource = self;
        store.subscribe(self);
    }
    
    @IBAction func addGroup(_ sender: Any) {
        print("Click");
        
        let alert = UIAlertController(title: "Add new", message: "Add a new group", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your group name";
        }
        
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { action in
        }))

        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            if let data = alert.textFields?.first?.text {
                if (data == "") {
                    return ;
                }
                let item: ItemGroup = ItemGroup(value: ["name": data])
                store.dispatch(addGroupAction(group: item));
            }
        }))
        
        self.present(alert, animated:true, completion: nil);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let reciever = segue.destination as! ItemController;
        
        if let indexPath = tblView.indexPathForSelectedRow {
            reciever.itemGroup = itemGroups[indexPath.row];
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemGroups.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(
            withIdentifier: "cellTest", for: indexPath
            ) as! SwipeTableViewCell;
        cell.textLabel?.text = itemGroups[indexPath.row].name;
        
        cell.delegate = self;
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);

        //controller.performSegue(withIdentifier: "groupToItems", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        switch orientation {
        case .right:
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                store.dispatch(removeGroupAction(id: indexPath.row))
            }
            deleteAction.image = UIImage(named: "delete")

            return [deleteAction]
        case.left:
            let completeAction = SwipeAction(style: .default, title: "Complete") {action, indexPath in
                
            }
            completeAction.backgroundColor = UIColor.systemGreen;
            
            completeAction.image = UIImage(named: "Complete");
            
            return [completeAction];
        }
    }
}

extension ViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = AppState;
        
    func newState(state: AppState) {
        let groups = state.itemGroups.groups;
        itemGroups = groups;
        tblView.reloadData();
    }
}
