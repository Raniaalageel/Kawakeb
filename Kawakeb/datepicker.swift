//
//  datepicker.swift
//  Kawakeb
//
//  Created by Modhy Abduallh on 28/05/1444 AH.
//

import UIKit

extension UITextField {
    
    func setDatePickerAsInputViewFor(target:Any, selector:Selector) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        datePicker.preferredDatePickerStyle = .compact
        datePicker.tintColor = .systemBlue
        self.inputView = datePicker
        
       let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 60.0))
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tapCancel))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: nil, action: selector)
        toolBar.setItems([cancel,flexibleSpace, done], animated: false)
        self.inputAccessoryView = toolBar
    }
    
      @objc func tapCancel() {
          self.resignFirstResponder()
      }
  }