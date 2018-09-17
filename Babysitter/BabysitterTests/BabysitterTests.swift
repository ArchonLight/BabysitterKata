//
//  BabysitterTests.swift
//  BabysitterTests
//
//  Created by Michael Cannell on 9/16/18.
//  Copyright © 2018 Altrius Ltd. All rights reserved.
//

import XCTest
@testable import Babysitter

class BabysitterTests: XCTestCase {
    
    let utility = Utility()
    let babysitter = BabysitterViewController()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConvertDateStringToDateIsNotNil(){
        let stringDate = "2018-09-17 19:00:00 -0400"
        let newDate = utility.convertDateStringToDate(dateString: stringDate)
        XCTAssertNotNil(newDate)
    }
    
    func testConvertDateStringToDateReturnsDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd HH:mm:ss Z"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let testDate = Date()
        let stringDate = dateFormatter.string(from: testDate)
        let newDate = utility.convertDateStringToDate(dateString: stringDate)
        
//        XCTAssertEqual((Date)testDate, newDate)
        XCTAssertEqual(testDate.timeIntervalSinceReferenceDate, newDate.timeIntervalSinceReferenceDate, accuracy: 0.9)
    }
    
    func testFormatChargeIntoCurrencyIsNotNil(){
        let cost: Float = 35.50
        let stringFormattedCost = utility.formatChargeIntoCurrency(charge: cost)
        XCTAssertNotNil(stringFormattedCost)
    }
    
    func testFormatChargeIntoCurrencyReturnsString(){
        let currencyFormatter = NumberFormatter()
        currencyFormatter.locale = Locale.current
        currencyFormatter.numberStyle = .currency
        let testCost: Float = 35.50
        let stringCost = utility.formatChargeIntoCurrency(charge: testCost)
        XCTAssertEqual(stringCost, "$35.50")
    }
    
    func testDifferenceInHoursBetweenTwoDates(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd HH:mm:ss Z"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let dateString1 = "2018-09-17 03:00:00 -0400"
        let dateString2 = "2018-09-17 18:00:00 -0400"
        let date1 = dateFormatter.date(from: dateString1)
        let date2 = dateFormatter.date(from: dateString2)
        let numOfHours = utility.differenceInHoursBetweenTwoDates(fromDate: date1!, toDate: date2!, allowFractional: false)
        XCTAssertEqual(numOfHours, 15)
    }
    
}
