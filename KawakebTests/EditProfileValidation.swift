//
//  EditProfileValidation.swift
//  KawakebTests
//
//  Created by Rania Alageel on 15/07/1444 AH.
//

@testable import Kawakeb
import XCTest

class EditProfileValidation: XCTestCase {

    var validation: Editprofile!

    
    override func setUp() {
        super.setUp()
        validation = Editprofile()
    }
    
    override func tearDown() {
        super.tearDown()
        validation = nil
    }
    
    
    func test_is_valid_update_Email() throws {
        
        let emailInput = "Sara@gmail"
        XCTAssertFalse(validation.isValidEmailR(emailID: emailInput))
    }
    
     
    func test_is_valid_update_Name() {
        
        let name = "س"
        XCTAssertFalse(validation.isValidCharacterName(nameText: name))
    }
    
    

}
