//
//  DateFormatter.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 06.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import Foundation

extension Date {
    func timeAgoFormatted() -> String {
        
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = minute * 60
        let day = hour * 24
        let month = day * 30
        let year = day * 365
        
        if secondsAgo < minute {
            return "a minute ago"
            
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute) minutes ago"
            
        } else if secondsAgo < day {
            return "\(secondsAgo / hour) hours ago"
            
        } else if secondsAgo < month {
            return "\(secondsAgo / day) days ago"
            
        } else if secondsAgo < year {
            return "\(secondsAgo / month) months ago"
        }
        
        return "\(secondsAgo / year) years ago"
    }
}
