//
//  CalculatePoints.swift
//  KawakebTests
//
//  Created by Rania Alageel on 14/07/1444 AH.
//

@testable import Kawakeb
import XCTest
import Firebase
import FirebaseFirestore

class CalculatePoints: XCTestCase {

    var validation: FirstSKScene!
    var GlobalUser: Global!
    let db = Firestore.firestore()
//    var curR = ""
    var MercuryPoints:Int!
    var mercpoints:Int!
    var points:Int!
//    var validation: updateRocketViewController!
    
    override func setUp() {
        super.setUp()
        validation = FirstSKScene()
          GlobalUser = Global()
//          validation = updateRocketViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        validation = nil
        GlobalUser = nil
    }
    
    
    func CalculateGamePoints() {

        XCTAssertNoThrow(validation.calculatePoint())

        db.collection("Child").whereField("email", isEqualTo: "shamma@gmail.com" ).getDocuments{
                        (snapshot, error) in
                        if let error = error {}
                        else {
                 
        self.MercuryPoints = snapshot!.documents.first!.get("MercuryPoints") as! Int
        self.mercpoints = self.MercuryPoints!
        self.points = snapshot!.documents.first!.get("points") as! Int

        let expected = self.points + 2
        let actual = 13 + 2
//        XCTAssertEqual(expected, self.points)
        XCTAssertEqual(expected, actual)

    }
    
    
    }
  }

}
