//
//  ViewController.swift
//  Babysitter
//
//  Created by Michael Cannell on 9/16/18.
//  Copyright © 2018 Altrius Ltd. All rights reserved.
//

import UIKit

class BabysitterViewController: UIViewController {
    @IBOutlet weak var totalChargeLabel: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    
    var startTime: Date?
    var bedTime: Date?
    var midnightTime: Date?
    var endTime: Date?
    
    let utility = Utility()
    
    //setup constants for hourly wages
    let startToBedTimeWage: Float = 12.0
    let bedtimeToMidnightWage: Float = 8.0
    let midnightToEndOfJobWage : Float = 16.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Calculation Logic
    //calculate the nightly charge for hours worked
    private func calculateNightlyCharge(startTime: Date, bedTime: Date, midnightTime: Date, endTime: Date) -> Float {
        
        //calculate number of hours worked from startTime to endTime
        var numOfHoursForPhase1 = utility.differenceInHoursBetweenTwoDates(fromDate: startTime, toDate: bedTime, allowFractional: false) //startTime -> bedTime
        var numOfHoursForPhase2 = utility.differenceInHoursBetweenTwoDates(fromDate: bedTime, toDate: midnightTime, allowFractional: false) //bedTime -> midnightTime
        var numOfHoursForPhase3 = utility.differenceInHoursBetweenTwoDates(fromDate: midnightTime, toDate: endTime, allowFractional: false) //midnightTime -> endTime
        //check to see if endtime comes before bedtime
        let numOfHoursForBedTimeToEndTime = utility.differenceInHoursBetweenTwoDates(fromDate: bedTime, toDate: endTime, allowFractional: false) //bedTime -> endTime
        
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
    
    private func setCalculateButtonState(){
        //check if all date variables are set, if so, allow interaction on Calculate Button
    }
    
    @IBAction func setStartTimeAction(_ sender: UISlider) {
        //set startTime variable
    }
    
    @IBAction func setBedTimeAction(_ sender: UISlider) {
        //set bedTime variable
    }
    
    @IBAction func setEndTimeAction(_ sender: UISlider) {
        //set endTime variable
    }
    
    @IBAction func calculateTotalWages(_ sender: UIButton) {
//        calculateNightlyCharge(startTime: startTime, bedTime: bedTime, midnightTime: midnightTime, endTime: endTime)
    }
    
}

