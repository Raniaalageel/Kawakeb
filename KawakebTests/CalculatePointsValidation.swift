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
        
//        XCTAssertNoThrow(validation.calculatePoint())
//
//        db.collection("Child").whereField("email", isEqualTo: Global.shared.useremailshare ).getDocuments{
//                        (snapshot, error) in
//                        if let error = error {}
//                        else {
//
//        self.MercuryPoints = snapshot!.documents.first!.get("MercuryPoints") as! Int
//        self.mercpoints = self.MercuryPoints!
//        self.points = snapshot!.documents.first!.get("points") as! Int
//
//        let expected = self.points + 2
//        let actual = 13 + 2
////        XCTAssertEqual(expected,self.points)
//        XCTAssertEqual(expected, actual)
//      }
//
//    }
        
    let expected = 0+2
    let actual = validation.calculatePoint() as! Int
    XCTAssertEqual(expected, actual)

        
        
 }
   
}
    
    

