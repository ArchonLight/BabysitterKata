//This kata simulates a babysitter working and getting paid for one night. The rules are pretty straight forward.

//The babysitter:

//starts no earlier than 5:00PM
//leaves no later than 4:00AM
//gets paid $12/hour from start-time to bedtime
//gets paid $8/hour from bedtime to midnight
//gets paid $16/hour from midnight to end of job
//gets paid for full hours (no fractional hours)
//Feature
//As a babysitter
//In order to get paid for 1 night of work
//I want to calculate my nightly charge

import UIKit

struct Babysitter {
    //setup constants for hourly wages
    let startToBedTimeWage: Float = 12.0
    let bedtimeToMidnightWage: Float = 8.0
    let midnightToEndOfJobWage : Float = 16.0
    
    //calculate the nightly charge for hours worked
    func calculateNightlyCharge(startTime: Date, bedTime: Date, midnightTime: Date, endTime: Date) -> Float {
        return 0.0
    }
    
    //convert the Date from String to Date
    func convertDateStringToDate(dateString: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd HH:mm:ss Z"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: dateString)!
    }
    
}


let babysitter = Babysitter()
//setup time constants for the hours worked. -0400 sets to our timezone
let startTime = babysitter.convertDateStringToDate(dateString: "2018-09-16 17:00:00 -0400")
let bedTime = babysitter.convertDateStringToDate(dateString: "2018-09-16 21:00:00 -0400")
let midnightTime = babysitter.convertDateStringToDate(dateString: "2018-09-17 00:00:00 -0400")
let endTime = babysitter.convertDateStringToDate(dateString: "2018-09-17 00:00:00 -0400")
