//
//  resetpw.swift
//  Kawakeb
//
//  Created by Amani Aldahmash on 18/12/2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import CoreMedia

class resetpw: UIViewController {

    @IBOutlet weak var backbutton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var errorMsg: UILabel!
    
    @IBOutlet weak var resetB: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        backbutton.layer.cornerRadius =    backbutton.frame.width/2
         backbutton.layer.borderWidth = 6
         backbutton.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
         backbutton.clipsToBounds = true
        errorMsg.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    func isValid() -> (Bool, String) {
        errorMsg.isHidden = true   //
        
        guard let email = emailField.text?.trimmingCharacters(in: .whitespaces).lowercased() , !email.isEmpty
        else {
            errorMsg.isHidden = false
            errorMsg.text = "الرجاء ادخال البريد الالكتروني"
            return (false, "")
        }
       
        if !isValidEmail(emailID: email) {
            errorMsg.isHidden = false
            errorMsg.text = "الرجاء ادخال بريد صحيح"
            return (false, "")
        }
     
        return (true, email)
    }
    
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[0-9A-Za-z.]{1,30}+@[A-Za-z]{1,10}+\\.[A-Za-z]{1,5}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    @IBAction func pressB(_ sender: UIButton) {
        let validationResult = isValid()
if validationResult.0 == false { return
        }
        
        let email = validationResult.1
        print(email)
        Task{
        let db = Firestore.firestore()
        if await self.checkEmailExist(email: email, collection: "Child", field: "email"){
            print("does exist")
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                if let e=error{
                    print("FAILED TO SEND")
                }
                else{
                    let alert = UIAlertController(title: "تنبيه", message: "يمكنك  الان تغيير كلمة المرور عن طريق  البريد المرسل", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)}}
                                          
                                         }
                else {
                    print("does not exist")
                    let alert = UIAlertController(title: "تنبيه", message: "البريد الالكتروني او كلمةالمرور غير صحيح", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)}
                
        }}
          
           
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
func checkEmailExist(email: String, collection: String, field: String) async -> Bool {
   // print("what??")
    let db = Firestore.firestore()
    do {
        let snapshot = try await db.collection(collection).whereField(field, isEqualTo: email).getDocuments()
        print("COUNT ", snapshot.count)
        print("not added")
        return snapshot.count != 0
    } catch {
        print(error.localizedDescription)
        print("added")
        return false
    }
    
    //return false
}

}
