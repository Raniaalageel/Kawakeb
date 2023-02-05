//
//  RegisterationValidation.swift
//  KawakebTests
//
//  Created by Rania Alageel on 14/07/1444 AH.
//

@testable import Kawakeb
import XCTest
import FirebaseAuth

class RegisterationValidation: XCTestCase {

    var validation: RegisterViewController!

    
    override func setUp() {
        super.setUp()
        validation = RegisterViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        validation = nil
    }
    
    
    func test_is_valid_Email() throws {
        
        let emailInput = "Rania@gmail.com"
        XCTAssertTrue(validation.isValidEmailR(emailID: emailInput))
        
//        let emailInput2 = "Sara@gmail"
//        XCTAssertTrue(validation.isValidEmailR(emailID: emailInput2))
        
    }
    
    func test_is_valid_Password()  {
        
//        let PasswordInput = "12345678"
//        XCTAssertTrue(validation.isValidPasswordR(PasswordText: PasswordInput))
        
        let PasswordInput2 = "1122334455667788"
        XCTAssertFalse(validation.isValidPasswordR(PasswordText: PasswordInput2))
        
    }
    
     
    func test_is_valid_Name() {
        
        let name = "رانيا"
        XCTAssertTrue(validation.isValidCharacterName(nameText: name))
        
//        let name2 = "س"
//        XCTAssertTrue(validation.isValidCharacterName(nameText: name2))
        
    }
    
    
    
    
    
    func test_is_userInfo_Stored(){
        
       let useremailshare = "Sara@gmail.com"
       let userpasswordshare = "12345678"
        
        Auth.auth().createUser(withEmail: useremailshare, password: userpasswordshare) { authResult , error in
            guard let userId  = authResult?.user.uid else {return}
            
            XCTAssertNoThrow(self.validation.storeUserInformation(id: userId))
        
    }
}

    

    
    
}
