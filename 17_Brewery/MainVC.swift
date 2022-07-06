//
//  MainVC.swift
//  17_Brewery
//
//  Created by 이윤수 on 2022/07/06.
//

import UIKit

import Kingfisher

class MainVC : UITableViewController{
    
    var beerList : [Beer] = [Beer(id: 0, name: "name", tageline: "tag", description: "description", brewers_Tips: "tips", image_URL: "img", food_Paring: ["food"])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Brewery"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.tableView.register(BeerListCell.self, forCellReuseIdentifier: "BeerListCell")
        self.tableView.rowHeight = 150
    }
}

extension MainVC{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("bbbb")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListCell") as? BeerListCell else {return UITableViewCell()}
        guard let url = URL(string: self.beerList[indexPath.row].image_URL ?? "") else {return UITableViewCell()}
       
        cell.imgView.kf.setImage(with: url)
        cell.mainTitle.text = self.beerList[indexPath.row].name
        cell.subTitle.text = self.beerList[indexPath.row].description
            
        return cell
    }
}
