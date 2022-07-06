//
//  DetailVC.swift
//  17_Brewery
//
//  Created by 이윤수 on 2022/07/06.
//

import UIKit

class DetailVC : UITableViewController{
    var beer : Beer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.beer?.name ?? "NO NAME BEER"
        
        self.tableView = UITableView(frame: self.tableView.frame, style: .insetGrouped)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "detailCell")
        self.tableView.rowHeight = UITableView.automaticDimension
    }
}

