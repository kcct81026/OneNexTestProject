//
//  CustomDateFormatter.swift
//  CodeTestOneNex
//
//  Created by AyeSuNaing on 28/10/2023.
//

import Foundation

func customDateString(dateString: String) -> String {
    let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
       dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

       if let date = dateFormatter.date(from: dateString) {
           let formatter = DateFormatter()
           formatter.dateFormat = "d' 'MMM"
           let formattedString = formatter.string(from: date)
           return formattedString
       } else {
           return "Invalid Date"
       }
}

