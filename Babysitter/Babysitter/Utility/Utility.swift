//
//  Utility.swift
//  Babysitter
//
//  Created by Michael Cannell on 9/16/18.
//  Copyright © 2018 Altrius Ltd. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    let fractionalAllowed: Bool = false
    
    //MARK: Date Formatter
    //convert the Date from String to Date
    public func convertDateStringToDate(dateString: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd HH:mm:ss Z"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: dateString)!
    }
    
    //MARK: Number Formatter
    //Format our charge calculation into readable String
    public func formatChargeIntoCurrency(charge: Float) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.locale = Locale.current
        currencyFormatter.numberStyle = .currency
        return currencyFormatter.string(from: charge as NSNumber)!
    }
    
    //Need to get the number of hours worked to cacluate wages.
    //First get the difference in hours between two dates
    public func differenceInHoursBetweenTwoDates(fromDate: Date, toDate: Date, allowFractional: Bool) -> Int{
        
        //set new variables to current dates, if fractional is allowed, just skip rounding to the top of the hour
        var fractionalFromDate = fromDate
        var fractionalToDate = toDate
        
        //if fractional is not allowed, get the floor of the hour
        if !allowFractional {
            fractionalFromDate = getFloorForCurrentHour(date: fromDate)!
            fractionalToDate = getCeilingForCurrentHour(date: toDate)!
        }
        
        return Calendar.current.dateComponents([.hour], from: fractionalFromDate, to: fractionalToDate).hour ?? 0
    }
    
    //MARK: Private functions
    //take the current hour of supplied date and return it to the top of the hour
    private func getFloorForCurrentHour(date: Date) -> Date?{
        var components = NSCalendar.current.dateComponents([.minute], from: date)
        let minute = components.minute ?? 0
        components.minute = -minute
        return Calendar.current.date(byAdding: components, to: date)
    }
    
    //take the current hour of supplied date and advance it to the top of the NEXT hour
    private func getCeilingForCurrentHour(date: Date) -> Date?{
        var components = NSCalendar.current.dateComponents([.minute], from: date)
        let minute = components.minute ?? 0
        components.minute = +minute
        return Calendar.current.date(byAdding: components, to: date)
    }
}
