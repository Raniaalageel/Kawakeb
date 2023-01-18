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
        let datePicker = UIDatePicker(frame: CGRect(x: 20, y: 100, width: 500, height: 200))
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.tintColor = .systemBlue
//
        let calendar = Calendar.current
               var minDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
                      minDateComponent.day = 01
                      minDateComponent.month = 01
                      minDateComponent.year = 2000
                      let minDate = calendar.date(from: minDateComponent)
       //               print(" min date : \(minDate)")
               var maxDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
                      maxDateComponent.day = 31
                       maxDateComponent.month = 12
                       maxDateComponent.year = 2019

                       let maxDate = calendar.date(from: maxDateComponent)
       //                print("max date : \(maxDate)")
               datePicker.minimumDate = minDate
               datePicker.maximumDate = maxDate
//
        self.inputView = datePicker
           // view.addSubview(datePicker)
//        datePicker.preferredDatePickerStyle = .wheels
        
        
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

