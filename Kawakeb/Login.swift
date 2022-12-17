//
//  Login.swift
//  Kawakeb
//
//  Created by Amani Aldahmash on 15/12/2022.
//


import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import CoreMedia
//var useremailshare : String = ""



class Login: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextfiled1: UITextField!
    @IBOutlet weak var passwordTextfiled1: UITextField!
    @IBOutlet weak var validationMassege1: UILabel!
    @IBOutlet weak var validationMessegepass1: UILabel!
        @IBOutlet weak var buttonlogin1: UIButton!
    
    //


    override func viewDidLoad() {
        super.viewDidLoad()
        validationMassege1.isHidden = true
        validationMessegepass1.isHidden = true
        self.emailTextfiled1.delegate = self
      
        self.passwordTextfiled1.delegate = self
        self.tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
        
    //    self.emailTextfiled.text = " 1232@lecture.ksu.edu.sa"
     //   self.passwordTextfiled.text = "12345678"
    }
  
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action:nil)
        
    }
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.resignFirstResponder()
        return(true)
    }
    //touch out
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //return key
 
    
    func isValid() -> (Bool, String, String) {
        validationMassege1.isHidden = true   // not show
        validationMessegepass1.isHidden = true
        
        guard let email = emailTextfiled1.text?.trimmingCharacters(in: .whitespaces).lowercased() , !email.isEmpty
        else {
            validationMassege1.isHidden = false
            validationMassege1.text = "الرجاء ادخال البريد  الالكتروني"
            return (false, "", "")
        }
        guard let password = passwordTextfiled1.text, !password.isEmpty else {
            validationMessegepass1.isHidden = false
            validationMessegepass1.text = "الرجاء ادخال كلمة  المرور"
            return (false, "", "")
        }
        if !isValidEmail(emailID: email) {
            validationMassege1.isHidden = false
            validationMassege1.text = "الرجاء ادخال بريد صحيح"
            return (false, "", "")
        }
      /*  if password.count != 8 {
            validationMessegepass.isHidden = false
            validationMessegepass.text = "Please enter password with 8 number "
            return (false, "", "")
        }*/
        
        
        return (true, email, password)
    }
        
        
@IBAction func loginpressed(_ sender: Any) {
        
            let validationResult = isValid()
    if validationResult.0 == false { return
            }
    
    //
            let email = validationResult.1
            let password = validationResult.2
            Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                if let e=error{   //if no connect with firebase
                    print("failed")
                    let alert = UIAlertController(title: "تنبيه", message: "البريد الالكتروني او كلمةالمرور غير صحيح", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                   // print(e)
                }else{   //user Auth in firebase
                    print("sucsses")
                    
                    Task {
                        let db = Firestore.firestore()
                        if await self.checkEmailExist(email: email, collection: "Child", field: "email") {
                            print("child exists")
                       //     Global.shared.useremailshare = email
                            guard let child = try await db.collection("Child").whereField("email", isEqualTo:  email).getDocuments().documents.first?.documentID else {return}
                            
                            db.collection("Child").whereField("email", isEqualTo: email).getDocuments{
                                (snapshot, error) in
                                if let error = error {
                                    print("FAIL2 ")
                                }
                                else{
                                    print("SUCCESS2")
                                    let pw = snapshot!.documents.first!.get("password") as! String
                                    print(pw)
                                    
                                    if(pw == password){
                                        self.performSegue(withIdentifier: "go", sender: self)}
                                    else
                                    {
                                        print("does not exist")
                                        let alert = UIAlertController(title: "تنبيه", message: "البريد الالكتروني او كلمةالمرور غير صحيح", preferredStyle: .alert)
                                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                        self.present(alert, animated: true, completion: nil)
                                    }
                                }
                            }
                        }
                        
                                                       
//                                                       try await db.collection("Unistudent").document(stidentis).setData([
//                                                           "token": Global.shared.Token
//                                                       ],merge: true) { err in
//                                                           if let err = err {
//                                                               print("not Add token  : \(err)")
//                                                           } else {
//                                                               print(" Add token sucsseful ")
//                                                           } }

                         

                      //      print("this is the email amani: " + email)
                         //   print("this is the global amani: " + Global.shared.useremailshare)
                            // students view
                        
//                            if await !self.checkEmailExist(email: email, collection: "Lecturer", field: "EmailLecture") {
//                                await self.storeUserInformation(collection: "Lecturer", data: ["EmailLecture": email])
//                            }
                           // self.NotificationLec()
                           // self.LectureNotificationForm()
                          //  if self.isValidEmailLectures(emailID: email) == true  {
                              //  self.storeLecturesInformation() }
                         //MODHI & Y
                          //  Global.shared.useremailshare = email
                        
                        else {
                            print("does not exist")
                            let alert = UIAlertController(title: "تنبيه", message: "البريد الالكتروني او كلمةالمرور غير صحيح", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            //  self.storeUserInformation()
                            // self.performSegue(withIdentifier: "gotoStudents", sender: self)
                            // Global.shared.useremailshare = email
                            
                        } //end else
                        
                    }  //end tak
                } //end elsee
                
                    

            } //end sign in
        }   //end loginpressed
    
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[0-9A-Za-z]{1,30}+@[A-Za-z]{1,10}+\\.[A-Za-z]{1,5}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
//    func isValidEmailSttudent(emailID:String) -> Bool {
//        let emailRegEx = "[0-9]+@[A-Za-z]+\\.[A-Za-z]{2,}+\\.[A-Za-z]{3,}+\\.[A-Za-z]{2,}"
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailTest.evaluate(with: emailID)
//    }
//
//    func isValidEmailLectures(emailID:String) -> Bool {
//        let emailRegEx = "[0-9]+@[A-Za-z]+\\.[A-Za-z]{2,}+\\.[A-Za-z]{2,}"
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailTest.evaluate(with: emailID)
//    }
    
    
    
    //end
    
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
    
//    func storeUserInformation(collection: String, data: [String: Any]) async {
//        //  var ref: DocumentReference? = nil
//        // guard let uid=Auth.auth().currentUser?.uid else {return }
//        let db = Firestore.firestore()
//        do {
//            try await db.collection(collection).document().setData(data)
//        } catch {
//            print(error.localizedDescription)
//        }
//    }  //end func
       
}
