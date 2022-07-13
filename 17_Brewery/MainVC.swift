//
//  MainVC.swift
//  17_Brewery
//
//  Created by 이윤수 on 2022/07/06.
//

import UIKit

import Kingfisher

class MainVC : UITableViewController{
    
    var beerList : [Beer] = []
    var dataTasks = [URLSessionTask]()
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Brewery"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.tableView.register(BeerListCell.self, forCellReuseIdentifier: "BeerListCell")
        self.tableView.rowHeight = 150
        self.tableView.prefetchDataSource = self
        
        self.dataLoad(of: self.currentPage)
    }
}

extension MainVC{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListCell") as? BeerListCell else {return UITableViewCell()}
        guard let url = URL(string: self.beerList[indexPath.row].image_url ?? "") else {return UITableViewCell()}
       
        cell.imgView.kf.setImage(with: url)
        cell.mainTitle.text = self.beerList[indexPath.row].name
        cell.subTitle.text = self.beerList[indexPath.row].tag
            
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailVC()
        detailVC.beer = self.beerList[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

// DataFetching
private extension MainVC{
    func dataLoad(of page : Int){
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(page)"), self.dataTasks.firstIndex(where:{ task in
            task.originalRequest?.url == url
        }) == nil
        else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request){ [weak self] data, response, error in
            guard error == nil,
                    let self = self,
                    let response = response as? HTTPURLResponse,
                    let data = data,
                    let beers = try? JSONDecoder().decode([Beer].self, from: data)
            else{
                print("Error: URLSession data task \(error)")
                return
            }
            switch response.statusCode{
            case (200...299): // 성공
                self.beerList += beers
                self.currentPage += 1
                print(self.beerList)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case (400...499): // 클라이언트 에러
                print("클라이언트 에러")
            case (500...599): // 서버 에러
                print("서버 에러")
            default:
                print("에러")
            }
        }
        dataTask.resume()
        dataTasks.append(dataTask)
    }
}

extension MainVC : UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard self.currentPage != 1 else {return}
        
        indexPaths.forEach{
            if ($0.row + 1) / 25 + 1 == self.currentPage{
                self.dataLoad(of: self.currentPage)
            }
        }
    }
}
