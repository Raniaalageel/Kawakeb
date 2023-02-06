//
//  CalculatePointsValidation.swift
//  KawakebTests
//
//  Created by Rania Alageel on 15/07/1444 AH.
//

@testable import Kawakeb
import XCTest
import Firebase
import FirebaseFirestore

class CalculatePointsValidation: XCTestCase {

    var validation: FirstSKScene!
    var GlobalUser: Global!
    let db = Firestore.firestore()
    var MercuryPoints:Int!
    var mercpoints:Int!
    var points:Int!
    
    override func setUp() {
        super.setUp()
        validation = FirstSKScene()
        GlobalUser = Global()
    }
    
    override func tearDown() {
        super.tearDown()
        validation = nil
        GlobalUser = nil
    }
    
    
    func test_Calculate_First_Game_Point()  {
        
 
        let userPoint = validation.CalculatUserPoint(emailID: "shamma@gmail.com")
                        
//   *** the point of the user with email address = "shamma@gmail.com" is = 13
        
        let expected = 13
        
        XCTAssertEqual(userPoint, expected)
        
  
   }
}

