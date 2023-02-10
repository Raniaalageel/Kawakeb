//
//  Register2ViewController.swift
//  Kawakeb
//
//  Created by Rania Alageel on 19/07/1444 AH.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import CoreMedia


class Register2ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var bithdayTextField: UITextField!
    @IBOutlet weak var SecondButton: UIButton!
    @IBOutlet weak var Birthdayvalidation: UILabel!
    
    var bod = ""

    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.bithdayTextField.setDatePickerAsInputViewFor(target: self, selector: #selector(dateSelected))
     
        bithdayTextField.text = Global.shared.userbirthday
    }
    
    

//    @IBAction func birthdayy(_ sender: Any) {
//        bithdayTextField.isUserInteractionEnabled = true
//        self.bithdayTextField.setDatePickerAsInputViewFor(target: self, selector: #selector(dateSelected))
//    }
    
    @objc func dateSelected() {
          if let datePicker = self.bithdayTextField.inputView as? UIDatePicker {
              let dateFormatter = DateFormatter()
              dateFormatter.dateStyle = .full
              dateFormatter.dateFormat = "dd-MM-yyyy"
              dateFormatter.locale = NSLocale(localeIdentifier: "ar") as Locale
              self.bithdayTextField.text = dateFormatter.string(from: datePicker.date)
              bithdayTextField.textColor = .black
              
          }
        
          self.bithdayTextField.resignFirstResponder()
      }

    @IBAction func SecondButton(_ sender: UIButton) {
        //self.tabBarController?.tabBar.isHidden = true
      //  Birthdayvalidation.isHidden = true
        
      //  self.bithdayTextField.setDatePickerAsInputViewFor(target: self, selector: #selector(dateSelected))
        
        let validationResult = isValidbod()
        if validationResult.0 == false {

            return

        }
        
        let Birthday = validationResult.1

        Global.shared.userbirthday = Birthday

        bod = Birthday
        print("bod : " , Birthday)
       self.performSegue(withIdentifier: "goToCharacter", sender: self)

    }
    
    
    func isValidbod() -> (Bool, String, String) {
        
        guard let birthday = bithdayTextField.text?.trimmingCharacters(in: .whitespaces).lowercased() , !birthday.isEmpty
        else {
            Birthdayvalidation.isHidden = false
            Birthdayvalidation.text = "* الرجاء إدخال تاريخ الميلاد"
            return (false, "", "")
           }
//        if !isValidBirthday(BirthdayText: birthday) {
//            Birthdayvalidation.isHidden = false
//            Birthdayvalidation.text = "الرجاء إدخال تاريخ الميلاد بالشكل الصحيح"
//            return (false, "", "")
//        }
        return (true, birthday , "")
    }
    
    
    func isValidBirthday(BirthdayText:String) -> Bool {
        
        let BoDRegEx = "^(0[1-9]|[12][0-9]|3[01])[- \\.](0[1-9]|1[012])[- \\.](19|20)\\d\\d$"
        let BoDTest = NSPredicate(format:"SELF MATCHES %@", BoDRegEx)
        return BoDTest.evaluate(with: BirthdayText)
    }
    
}
