//
//  Date+Extension.swift
//  WalE
//
//  Created by Amrit Bhardwaj on 06/04/21.
//

import Foundation

extension Date {
    
    /// This method is for converting date to local time
    ///
    /// - Returns: local equivalent of the date on which operated
    func convertToLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    func effectiveCurrentDate() -> Date {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateFormatter.timeZone = .current
//        let date = dateFormatter.date(from: self)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        let finalDate = calendar.date(from: components)!
        return finalDate
    }
    
    
}
