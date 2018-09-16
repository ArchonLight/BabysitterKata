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
        //FIXME: This calculation will caclulate fractional hours - limit to whole hours in View?
        
        //calculate number of hours worked from startTime to endTime
        var numOfHoursForPhase1 = differenceInHoursBetweenTwoDates(fromDate: startTime, toDate: bedTime) //startTime -> bedTime
        var numOfHoursForPhase2 = differenceInHoursBetweenTwoDates(fromDate: bedTime, toDate: midnightTime) //bedTime -> midnightTime
        var numOfHoursForPhase3 = differenceInHoursBetweenTwoDates(fromDate: midnightTime, toDate: endTime) //midnightTime -> endTime
        //check to see if endtime comes before bedtime
        let numOfHoursForBedTimeToEndTime = differenceInHoursBetweenTwoDates(fromDate: bedTime, toDate: endTime) //bedTime -> endTime
        
        //We need to allow for bedTime to be after midnight and endTime to be before midnight
        //Check if bedtime is after midnight and adjust by subtracting the number of hours calculated that bedtime is after midnight
        numOfHoursForPhase1 = numOfHoursForPhase2<0 ? numOfHoursForPhase1+numOfHoursForPhase2 : numOfHoursForPhase1

        //check if endTIme is before Midnight by subtracting the number of hours calculated that midnightTime is after endTime
        numOfHoursForPhase2 = numOfHoursForPhase3<0 ? numOfHoursForPhase2+numOfHoursForPhase3 : numOfHoursForPhase2
        
        //check if endTime is before bedtime & midnight, if it is we only need to calculate startTime -> endTime
        if numOfHoursForBedTimeToEndTime<0 && numOfHoursForPhase3<0{
            numOfHoursForPhase1 = numOfHoursForPhase1+numOfHoursForBedTimeToEndTime
            numOfHoursForPhase2 = 0
            numOfHoursForPhase3 = 0
        }
        
        //calculate the charge in deimal to charge for each work span
        //prevent a negative phase charge from impacting the calculation
        let phase1Charge = numOfHoursForPhase1>0 ? Float(numOfHoursForPhase1)*startToBedTimeWage : 0
        let phase2Charge = numOfHoursForPhase2>0 ? Float(numOfHoursForPhase2)*bedtimeToMidnightWage : 0
        let phase3Charge = numOfHoursForPhase3>0 ? Float(numOfHoursForPhase3)*midnightToEndOfJobWage : 0
        
        
        return phase1Charge+phase2Charge+phase3Charge
    }
    
    //convert the Date from String to Date
    func convertDateStringToDate(dateString: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd HH:mm:ss Z"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: dateString)!
    }
    
    //Need to get the number of hours worked to cacluate wages.
    //First get the difference in hours between two dates
    func differenceInHoursBetweenTwoDates(fromDate: Date, toDate: Date) -> Int{
        return Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour ?? 0
    }
    
    //Format our charge calculation into readable String
    func formatChargeIntoCurrency(charge: Float) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.locale = Locale.current
        currencyFormatter.numberStyle = .currency
        return currencyFormatter.string(from: charge as NSNumber)!
    }
    
}


let babysitter = Babysitter()
//setup time constants for the hours worked. -0400 sets to our timezone
let startTime = babysitter.convertDateStringToDate(dateString: "2018-09-16 17:00:00 -0400")
let bedTime = babysitter.convertDateStringToDate(dateString: "2018-09-16 21:00:00 -0400")
let midnightTime = babysitter.convertDateStringToDate(dateString: "2018-09-17 00:00:00 -0400")
let endTime = babysitter.convertDateStringToDate(dateString: "2018-09-17 04:00:00 -0400")

let amountToCharge = babysitter.calculateNightlyCharge(startTime: startTime, bedTime: bedTime, midnightTime: midnightTime, endTime: endTime)
print("The babysitter made \(babysitter.formatChargeIntoCurrency(charge: amountToCharge)) tonight")
