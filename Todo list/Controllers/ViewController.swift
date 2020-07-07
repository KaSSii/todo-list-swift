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
    var selectedItemGroup: ItemGroup?;
    
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Todo Today";
        tblView.delegate = self
        tblView.dataSource = self;
        store.subscribe(self);
        tblView.rowHeight = UITableView.automaticDimension;
        tblView.register(UINib(nibName: "GroupRow", bundle: nil), forCellReuseIdentifier: "groupRow");
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }
    
    func setupLongPressGesture() {
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress))
        //longPressGesture.minimumPressDuration = 1.0 // 1 second press
        self.tblView.addGestureRecognizer(longPressGesture)
    }

    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer){
        print(gestureRecognizer.state.rawValue);
//        if gestureRecognizer.state == .began {
//            let touchPoint = gestureRecognizer.location(in: self.tblMessage)
//            if let indexPath = tblMessage.indexPathForRow(at: touchPoint) {
//
//            }
//        }
    }
    
    @IBAction func addGroup(_ sender: Any) {
        print("Click");
        
        let alert = UIAlertController(title: "Add new", message: "Add a new group", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your group name";
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter description"
        }
        
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { action in
        }))

        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            if let data = alert.textFields?.first?.text, let desc = alert.textFields?[1].text {
                if (data == "") {
                    return ;
                }
                let item: ItemGroup = ItemGroup(value: ["name": data, "groupDescription": desc]);
                store.dispatch(addGroupAction(group: item));
            }
        }))
        
        self.present(alert, animated:true, completion: nil);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender);
        
        let reciever = segue.destination as! ItemController;
        
        reciever.itemGroup = selectedItemGroup;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemGroups.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(
            withIdentifier: "groupRow", for: indexPath
            ) as! GroupRow;
        
        print(indexPath.row);
        
        cell.itemGroup = itemGroups[indexPath.row];
        
        return cell;
    }
    
    @objc func swipeCell(sender: UISwipeGestureRecognizer) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        selectedItemGroup = itemGroups[indexPath.row];
        
        self.performSegue(withIdentifier: "groupToItems", sender: self);
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
