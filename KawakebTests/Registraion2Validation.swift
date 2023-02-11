//
//  Registraion2Validation.swift
//  KawakebTests
//
//  Created by Rania Alageel on 20/07/1444 AH.
//

@testable import Kawakeb
import XCTest
import FirebaseAuth


class Registraion2Validation: XCTestCase {

    var validation: Register4ViewController!

    
    override func setUp() {
        super.setUp()
        validation = Register4ViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        validation = nil
    }
    
    
    func test_is_valid_Name() {

        let name = "رانيا"
        XCTAssertTrue(validation.isValidCharacterName(nameText: name))

//        let name2 = "س"
//        XCTAssertTrue(validation.isValidCharacterName(nameText: name2))

    }

    
    
}
