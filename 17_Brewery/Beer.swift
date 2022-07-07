//
//  Beer.swift
//  17_Brewery
//
//  Created by 이윤수 on 2022/07/06.
//

import Foundation

struct Beer : Decodable{
    let id : Int?
    let name, tagline, description, brewers_tips, image_url : String?
    let food_pairing : [String]?
    
    var tag : String{
        let tags = tagline?.components(separatedBy: ". ")
        let hashTags = tags?.map{
            "#" + $0.replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: ".", with: "")
                .replacingOccurrences(of: ",", with: "#")
        }
        return hashTags?.joined(separator: " ") ?? "" // 태그 치환
    }
    
}
