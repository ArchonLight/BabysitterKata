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
        //default charges to 0.0
        var phase1Charge: Float = 0.0
        var phase2Charge: Float = 0.0
        var phase3Charge: Float = 0.0
        
        //calculate number of hours worked from startTime to endTime
        var numOfHoursForPhase1 = differenceInHoursBetweenTwoDates(fromDate: startTime, toDate: bedTime)
        var numOfHoursForPhase2 = differenceInHoursBetweenTwoDates(fromDate: bedTime, toDate: midnightTime)
        let numOfHoursForPhase3 = differenceInHoursBetweenTwoDates(fromDate: midnightTime, toDate: endTime)
        
        //We need to allow for bedTime to be after midnight and endTime to be before midnight
        //Check if bedtime is after midnight and adjust
        if numOfHoursForPhase2<0{
            //subtract the number of hours calculated that bedtime is after midnight
            numOfHoursForPhase1 = numOfHoursForPhase1+numOfHoursForPhase2
        }
        
        //check if endTIme is before Midnight
        if numOfHoursForPhase3<0{
            numOfHoursForPhase2 = numOfHoursForPhase2+numOfHoursForPhase3
        }
        
        //calculate the charge in deimal to charge for each work span
        //prevent a negative phase charge from impacting the calculation
        if numOfHoursForPhase1>0{
            phase1Charge = Float(numOfHoursForPhase1)*startToBedTimeWage
        }

        if numOfHoursForPhase2>0{
            phase2Charge = Float(numOfHoursForPhase2)*bedtimeToMidnightWage
        }

        if numOfHoursForPhase3>0{
            phase3Charge = Float(numOfHoursForPhase3)*midnightToEndOfJobWage
        }
        
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
let endTime = babysitter.convertDateStringToDate(dateString: "2018-09-16 23:00:00 -0400")

let amountToCharge = babysitter.calculateNightlyCharge(startTime: startTime, bedTime: bedTime, midnightTime: midnightTime, endTime: endTime)
print("The babysitter made \(babysitter.formatChargeIntoCurrency(charge: amountToCharge)) tonight")
