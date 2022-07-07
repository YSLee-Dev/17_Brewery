//
//  DetailVC.swift
//  17_Brewery
//
//  Created by 이윤수 on 2022/07/06.
//

import UIKit

import Kingfisher

class DetailVC : UITableViewController{
    var beer : Beer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.beer?.name ?? "NO NAME BEER"
        
        self.tableView = UITableView(frame: self.tableView.frame, style: .insetGrouped)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "detailCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        
        let headerView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300))
        let url = URL(string: beer?.image_url ?? "")
        headerView.kf.setImage(with: url)
        headerView.contentMode = .scaleAspectFit
        
        self.tableView.tableHeaderView = headerView
    }
}

extension DetailVC{
    override func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 3:
            return self.beer?.food_pairing?.count ?? 0
        
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "ID"
        case 1:
            return "Description"
        case 2:
            return "Brewers Tips"
        case 3:
            let foodPairingEmpty = self.beer?.food_pairing?.isEmpty ?? true
            return foodPairingEmpty ? nil : "Food Paring"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "detailCell")
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        
        switch indexPath.section{
        case 0:
            cell.textLabel?.text = "\(self.beer?.id ?? 0)"
            return cell
        case 1:
            cell.textLabel?.text = "\(self.beer?.description ?? "No Description")"
            return cell
        case 2:
            cell.textLabel?.text = "\(self.beer?.brewers_tips ?? "No Tips")"
            return cell
        case 3:
            cell.textLabel?.text = "\(self.beer?.food_pairing ?? ["No FoodParing"])"
            return cell
        default:
            return cell
        }
    }
}
