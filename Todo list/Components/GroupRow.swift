//
//  GroupRow.swift
//  Todo list
//
//  Created by Jack on 2/7/20.
//  Copyright © 2020 Jack. All rights reserved.
//

import UIKit

class GroupRow: UITableViewCell {

    var itemGroup: ItemGroup? {
        didSet {
            title?.text =  itemGroup?.name;
            groupDescription?.text = itemGroup?.groupDescription;
            
            let completedItems = itemGroup!.items.filter { item -> Bool in
                item.completed;
            }.count
            
            total?.text = "\(completedItems) of \(itemGroup!.items.count)";
        }
    }
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var groupDescription: UILabel!
    @IBOutlet weak var total: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        title?.text = "Hello world";
        print("yo you");
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
