//
//  Category.swift
//  Todo list
//
//  Created by Jack on 1/7/20.
//  Copyright © 2020 Jack. All rights reserved.
//

import Foundation
import UIKit

class CategoryRow: UITableViewCell {
    var group: ItemGroup? {
        didSet {
            title.text = group?.name
            groupDescription.text = "Testing actual items";
            totalItems.text = "Completed: \(group!.items.count)/10";
        }
    }
    
    lazy var title: UILabel = {
        var label = UILabel();
        label.font = .boldSystemFont(ofSize: 16.0)
        return label;
    }();
    
    lazy var totalItems: UILabel = {
        var label = UILabel();
        label.font = .systemFont(ofSize: 10);
        return label;
    }()
    
    lazy var groupDescription: UILabel = {
        var label = UILabel();
        label.font = .systemFont(ofSize: 12);
        return label;
    }()
    
    lazy var containerStack: UIStackView = {
        var view = UIStackView();
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 10
        view.distribution = .fillEqually
        view.axis = .horizontal;
        
        return view;
    }()
    
    lazy var textContainer: UIStackView = {
        var view = UIStackView();
        
//        view.translatesAutoresizingMaskIntoConstraints = false;
        view.spacing = 10;
        view.axis = .vertical;
        return view
    }()
    
    lazy var rightColumn: UIStackView = {
        var view = UIStackView();
        view.axis = .vertical;
        view.alignment = .trailing;
        return view;
    }();
    
    lazy var rightContainer: UIStackView = {
        var view = UIStackView();
        view.axis = .horizontal;
        view.spacing = 20;
        return view;
    }();
    
    lazy var rightArrow: UIImageView = {
        var image = UIImage(systemName: "chevron.right");
        var imageView = UIImageView(image: image!);
        imageView.contentMode = .scaleAspectFit
        return imageView;
    }();
    
    override func layoutSubviews() {
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        addSubview(containerStack);
//        containerStack.addArrangedSubview(title);
        
        containerStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        containerStack.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        containerStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        containerStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        
        containerStack.addArrangedSubview(textContainer);
        containerStack.addArrangedSubview(rightColumn);
        
        rightColumn.addArrangedSubview(rightContainer)
        
        rightContainer.addArrangedSubview(totalItems);
        rightContainer.addArrangedSubview(rightArrow);
        
        rightArrow.frame = CGRect(x: 0, y: 0, width: 20, height: 20);
        
        
        
        textContainer.addArrangedSubview(title);
        textContainer.addArrangedSubview(groupDescription);
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
