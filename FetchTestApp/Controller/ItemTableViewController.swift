//
//  ItemTableViewController.swift
//  FetchTestApp
//
//  Created by Luke Morse on 1/19/20.
//  Copyright © 2020 Luke Morse. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {
    
    var items = [Item]();
    var bgColors: [UIColor] = [
        UIColor.init(red: 137/255, green: 105/255, blue: 120/255, alpha: 1),
        UIColor.init(red: 131/255, green: 151/255, blue: 145/255, alpha: 1),
        UIColor.init(red: 170/255, green: 192/255, blue: 175/255, alpha: 1),
        UIColor.init(red: 255/255, green: 212/255, blue: 202/255, alpha: 1)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        print(items)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemCell {
            
            //Pass name and listId into cell labels
            cell.nameLabel.text = items[indexPath.row].name
            let listId = items[indexPath.row].listId
            cell.listIdLabel.text = String(listId)
            
            //Change cell color according to listId
            let bgColorIdx = listId - 1
            if bgColorIdx >= 0 && bgColorIdx < bgColors.count {
                cell.contentView.backgroundColor = bgColors[bgColorIdx]
            } else {
                cell.contentView.backgroundColor = .white
            }
            return cell
        } else {
            let cell = UITableViewCell()
            return cell;
        }
    }
}
