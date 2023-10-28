//
//  Helper.swift
//  CodeTestOneNex
//
//  Created by AyeSuNaing on 28/10/2023.
//

import Foundation
import UIKit



struct Category {
    let title: String
    let icon: UIImage
}

var categoryList: [Category] = getImageList()

func getImageList() -> [Category] {
    var returnList: [Category] = []
    let imageNames = ["Rewards", "Brands", "Campaigns", "Gift", "Leaderboard", "Wishlist", "Member Card", "Exclusive"]

    for (index, name) in imageNames.enumerated() {
        if let iconImage = UIImage(named: "reward\(index + 1)") {
            let category = Category(title: name, icon: iconImage)
            returnList.append(category)
        }
    }

    return returnList
}


var announcementList : [String] = [
    "Ja molone london mother\'s day",
    "Women\'s leadership conference"
]



