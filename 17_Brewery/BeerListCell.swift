//
//  BeerListCell.swift
//  17_Brewery
//
//  Created by 이윤수 on 2022/07/06.
//

import UIKit
import Then
import SnapKit

class BeerListCell : UITableViewCell{
    
    var imgView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .red
    }
    
    var mainTitle = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.numberOfLines = 2
    }
    
    var subTitle = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .blue
        $0.numberOfLines = 0
    }
    
    override func layoutSubviews() {
        [self.imgView, self.mainTitle, self.subTitle].forEach{ [weak self] in
            self?.contentView.addSubview($0)
        }
        
        self.imgView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(15)
            $0.width.equalTo(80)
            $0.height.equalTo(120)
            $0.centerY.equalToSuperview()
        }
        
        self.mainTitle.snp.makeConstraints{
            $0.leading.equalTo(self.imgView.snp.trailing).offset(10)
            $0.bottom.equalTo(self.imgView.snp.centerY)
            $0.trailing.equalToSuperview().inset(15)
        }
        
        self.subTitle.snp.makeConstraints{
            $0.leading.trailing.equalTo(self.mainTitle)
            $0.top.equalTo(self.imgView.snp.centerY).offset(5)
        }
        
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
        
    }
}
