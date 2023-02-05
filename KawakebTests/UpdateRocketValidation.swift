//
//  UpdateRocketValidation.swift
//  KawakebTests
//
//  Created by Rania Alageel on 15/07/1444 AH.
//
@testable import Kawakeb
import XCTest
import Firebase
import FirebaseFirestore

class UpdateRocketValidation: XCTestCase {

    
    var validation: updateRocketViewController!
    var GlobalUser: Global!
    let db = Firestore.firestore()
    var curR = ""
    
    
    override func setUp() {
        super.setUp()
          GlobalUser = Global()
          validation = updateRocketViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        validation = nil
        GlobalUser = nil
    }

    
    
    func test_updateRoucket() {
        
//        XCTAssertNoThrow(validation.changeRocket((Any).self))
        let UserCurentRocket =  db.collection("Child").whereField("email", isEqualTo: Global.shared.useremailshare).getDocuments{
            (snapshot, error) in
            if let error = error {}
            else{}
            
            let myROCK = snapshot!.documents.first!.get("currentRocket") as! String
            self.curR = myROCK
            
            XCTAssertEqual(myROCK, self.curR)
        
        
    }
}

}
