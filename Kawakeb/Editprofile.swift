//
//  Editprofile.swift
//  Kawakeb
//
//  Created by Modhy Abduallh on 28/05/1444 AH.
//

import UIKit
import Firebase
import FirebaseFirestore

protocol EditprofileDelegate {
    func userUpdated(child: Child)
}

class Editprofile: UIViewController , UITextFieldDelegate {
    var userId = ""
    let firestore = Firestore.firestore()

    
    @IBOutlet weak var char: UILabel!
    @IBOutlet weak var Uname: UITextField!
    @IBOutlet weak var Udob: UITextField!
    @IBOutlet weak var Uemail: UITextField!
  
    @IBOutlet weak var Eval: UILabel!
    
    @IBOutlet weak var Dval: UILabel!
    
    var delegate : EditprofileDelegate!
    var Lemail = ""
    var bod = ""
    var CharacterName = ""
    var Lpassword = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let id = Auth.auth().currentUser?.uid {
            userId = id
        }
        
//        userId = "9hITbFsJWedRbhIoNCL8LpfhU7o2"
        
        firestore.collection("Child").document(userId).getDocument { [self]snapshot, error in
            if error == nil {
                // get user data
                guard let userData = snapshot else {return}
                Uname.text = userData["name"] as? String
                Uemail.text = userData["email"] as? String
                Udob.text = userData["dob"] as? String
                char.text =  userData["character"] as? String
                                if ( char.text == "girl"){
                                        let imageName = "girl.png"
                                        let image = UIImage(named: imageName)
                                        let imageView = UIImageView(image: image!)
                                        imageView.frame = CGRect(x: 250, y: 100, width: 300, height: 300)
                                        view.addSubview(imageView)
                                        }else if (char.text == "boy"){
                                            let imageName = "boy.png"
                                            let image = UIImage(named: imageName)
                                            let imageView = UIImageView(image: image!)
                                            imageView.frame = CGRect(x: 250, y: 100, width: 300, height: 300)
                                            view.addSubview(imageView)
                                        }
                
            } else {
                // show error message
            }
        }
        
        self.Udob.setDatePickerAsInputViewFor(target: self, selector: #selector(dateSelected))
        
//        if let child = passedChild {
//            Uname.text = child.name
//            Uemail.text = child.email
//            Udob.text = child.dob
//
//            print(child.childID)
//
//            //            let formatter = DateFormatter()
//            ////            formatter.calendar = Calendar(identifier: .gregorian)
////            formatter.locale = Locale(identifier: "ar_DZ")
////            formatter.dateFormat = "dd/MM/yyyy"
////            print(formatter.string(from: Date()))
////
////
////            if let childDob = child.dob {
////                let childDate = formatter.date(from: childDob)
////
////                print(childDate)
////            }
//
//
//        }
        
    }
    
    @objc func dateSelected() {
          if let datePicker = self.Udob.inputView as? UIDatePicker {
              let dateFormatter = DateFormatter()
              dateFormatter.dateStyle = .full
              dateFormatter.dateFormat = "dd-MM-yyyy"
              self.Udob.text = dateFormatter.string(from: datePicker.date)
              Udob.textColor = .black
              
          }
          self.Udob.resignFirstResponder()
      }
    
//    func isValidR() -> (Bool, String) {
//        Eval.isHidden = true
//        guard let email = Uemail.text?.trimmingCharacters(in: .whitespaces).lowercased() , !email.isEmpty
//        else {
//           Eval.isHidden = false
//           Eval.text = "الرجاء إدخال البريد الالكتروني"
//            return (false, "")
//        }
//
//        if !isValidEmailR(emailID: email) {
//            Eval.isHidden = false
//            Eval.text = "الرجاء إدخال بريد الكتروني صحيح !"
//            return (false, "")
//        }
//        return (true, email)
//    }
    
    
    @IBAction func save(_ sender: Any) {
        
        let validationResult = isValidR()
                if validationResult.0 == false {return}
                
                let validationResult2 = isValidName()
                if validationResult2.0 == false {return}
        
        
        let childData : [String : Any] = ["name" : Uname.text, "email": Uemail.text, "dob": Udob.text]
        firestore.collection("Child").document(userId).updateData(childData) { [self] error in
            if error == nil {
                // update successfully
                let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! Profile
                profileVC.modalTransitionStyle = .crossDissolve
                profileVC.modalPresentationStyle = .fullScreen
                self.present(profileVC, animated: true)
                
            } else {
                // show error message
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        //self.navigationController?.popViewController(animated: true)
        let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! Profile
        profileVC.modalTransitionStyle = .crossDissolve
        profileVC.modalPresentationStyle = .fullScreen
        self.present(profileVC, animated: true)

    }
    func isValidEmailR(emailID:String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailTest.evaluate(with: emailID)
       }
    func isValidR() -> (Bool, String, String) {
           Eval.isHidden = true
          
           
           guard let email = Uemail.text?.trimmingCharacters(in: .whitespaces).lowercased() , !email.isEmpty
           else {
               Eval.isHidden = false
               Eval.text = "* الرجاء إدخال البريد الالكتروني"
               return (false, "", "")
           }
       
           if !isValidEmailR(emailID: email) {
               Eval.isHidden = false
               Eval.text = "* الرجاء إدخال بريد الكتروني صحيح"
               return (false, "", "")
           }
          
           
           return (true, email, "")
       }
    
    func isValidName() -> (Bool, String, String) {
           
           guard let Name = Uname.text?.trimmingCharacters(in: .whitespaces).lowercased() , !Name.isEmpty
           else {
               Dval.isHidden = false
               Dval.text = "* الرجاء إدخال اسم الشخصية"
               return (false, "", "")
              }
           if !isValidCharacterName(nameText: Name) {
               Dval.isHidden = false
               Dval.text = "* الرجاء إدخال اسم شخصية صحيح"
               return (false, "", "")
           }
           return (true, Name , "")
       }
    func isValidCharacterName(nameText:String) -> Bool {
            
            let NameRegEx = "\\w{2,12}"
            let NameTest = NSPredicate(format:"SELF MATCHES %@", NameRegEx)
            return NameTest.evaluate(with: nameText)
        }
        
        
        
        func checkEmailExist(email: String, collection: String, field: String) async -> Bool {
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
        }
    
    /*
    func getInfo (completion: @escaping (_ name: String?) -> Void) {
    
        guard let Uemail = Auth.auth().currentUser?.email else {
            
            completion(nil)
            return
        }
        print(Uemail)
        Firestore.firestore().collection("Child").document(Uemail).getDocument {
            (docSnapshot, error) in
            if let doc = docSnapshot {
                if let name = doc.get("name") as? String {
                    completion(name)
                    
                }
                
            }
            
            
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  /*
    var user : child! {
            didSet {
                updateUI(for: user)
            }
        }
    
    override func viewDidLoad() {
          super.viewDidLoad()
        getinfo()
        // Do any additional setup after loading the view.
      }

func getinfo() {
      let db = Firestore.firestore()
      db.collection("Child").whereField("email", isEqualTo:"leena99@gmail.com").getDocuments { (snapshot,error) in
          if let error = error {
                             print("FAIL ")
                         }
          else{
                             guard let lecturer = snapshot?.documents.first else {
                                 return  }
              
      }
}
    
}
*/











     /*
override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         }
     
     
     func updateUI(for user:child) {
         name.text = user.name
         email.text = user.email
         dob.text = user.dob
     }
     
     func loadProfile(letctrerID lid:String) {
         firestore.collection("Child").document(lid).getDocument { document, error in
             guard let doc = document, let userData  = doc.data() else {
                 //Inform user that there no document asscisated with the uid he have priovided
                 print("Error loadin user profile", error?.localizedDescription ?? "Unknown Error")
                 return
             }
             self.user = try! FirebaseDecoder().decode(child.self, from: userData)
         }
     }
 }
*/

*/
    
}

