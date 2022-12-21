//
//  RegisterViewController.swift
//  Kawakeb
//
//  Created by Rania Alageel on 21/05/1444 AH.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import CoreMedia



class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var Emailvalidation: UILabel!
    @IBOutlet weak var Passwordvalidation: UILabel!
    @IBOutlet weak var FirstButton: UIButton!
    
    
    @IBOutlet weak var bithdayTextField: UITextField!
    @IBOutlet weak var SecondButton: UIButton!
    @IBOutlet weak var Birthdayvalidation: UILabel!
    
    
    
    @IBOutlet weak var girl: UIButton!
    @IBOutlet weak var boy: UIButton!
    @IBOutlet weak var Charactervalidation: UILabel!
    @IBOutlet weak var ThirdButton: UIButton!
    
    
    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var CharacterNamevalidation: UILabel!
    @IBOutlet weak var CreateAccountButton: UIButton!
    
    
    
    var Lemail = ""
    var Lpassword = ""
    var bod = ""
    var Character = ""
    var CharacterName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.tabBarController?.tabBar.isHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action:nil)

        
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
    
    
    
    func isValidR() -> (Bool, String, String) {
        Emailvalidation.isHidden = true
        Passwordvalidation.isHidden = true
        
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespaces).lowercased() , !email.isEmpty
        else {
            Emailvalidation.isHidden = false
            Emailvalidation.text = "الرجاء إدخال البريد الالكتروني"
            return (false, "", "")
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            Passwordvalidation.isHidden = false
            Passwordvalidation.text = "الرجاء إدخال كلمة المرور"
            return (false, "", "")
        }
        if !isValidEmailR(emailID: email) {
            Emailvalidation.isHidden = false
            Emailvalidation.text = "الرجاء إدخال بريد الكتروني صحيح !"
            return (false, "", "")
        }
        if password.count != 8 {
            Passwordvalidation.isHidden = false
            Passwordvalidation.text = "الرجاء إدخال كلمة مرور مكونة من ٨ أرقام!"
            return (false, "", "")
        }
        
        
        return (true, email, password)
    }
    
    
    
    
    
    @IBAction func FirstButton(_ sender: UIButton) {
        
        self.tabBarController?.tabBar.isHidden = true
        Emailvalidation.isHidden = true
        Passwordvalidation.isHidden = true
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.tabBarController?.tabBar.isHidden = true

     
        let validationResult = isValidR()
        if validationResult.0 == false {
            
            return
            
        }
        
        
        
        let email = validationResult.1
        let password = validationResult.2
        
        print("email : " , email)
        print("password : " , password)
        
        Lemail = email
        Lpassword = password
        
        print("Lemail : " , Lemail)
        print("Lpassword : " , Lpassword)
        
        Global.shared.useremailshare = email
        Global.shared.userpasswordshare = password
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult , error in
                      if let e = error {
                          self.performSegue(withIdentifier: "goToBirthday", sender: self)
                        print("not exists email")
                         }else {
                             print("email exists")
                             self.Emailvalidation.isHidden = false
                             self.Emailvalidation.text = "الرجاء تغيير البريد الاكتروني"
                            
                }
        }
}// func
    

    @IBAction func SecondButton(_ sender: UIButton) {
        self.tabBarController?.tabBar.isHidden = true
        Birthdayvalidation.isHidden = true
        
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
    
    var whatCharacterPressed = ""
    
    @IBAction func ThirdButton(_ sender: UIButton) {
        self.tabBarController?.tabBar.isHidden = true
        Charactervalidation.isHidden = true
        Charactervalidation.text = "الرجاء اختيار الشخصية"
        Character = whatCharacterPressed
        Global.shared.usercharacter = Character
        print(" Character : " , Character)

        if isPressed {
        
//            if (whatCharacterPressed == "girl"){
//                selectedImage.image = UIImage(named:"girl.png")
//            }else{
//                selectedImage.image = UIImage(named:"boy.png")
//            }
            
        self.performSegue(withIdentifier: "goToCharacterName", sender: self)
//            if (Character == "girl"){
//            let imageName = "girl.png"
//            let image = UIImage(named: imageName)
//            let imageView = UIImageView(image: image!)
//            imageView.frame = CGRect(x: 293, y: 611, width: 246, height: 210)
//            view.addSubview(imageView)
//            }else if (Character == "boy"){
//                let imageName = "boy.png"
//                let image = UIImage(named: imageName)
//                let imageView = UIImageView(image: image!)
//                imageView.frame = CGRect(x: 293, y: 611, width: 246, height: 210)
//                view.addSubview(imageView)
//            }
        }else{
        Charactervalidation.isHidden = false
        }

    }
    
    
    var isPressed = false
    @IBAction func GirlPressed(_ sender: UIButton) {
        
    Charactervalidation.isHidden = true
    isPressed = true
//    girl.isHidden = true
    girl.backgroundColor = UIColor.lightGray
    boy.backgroundColor = UIColor.white
    print("Girl pressed")
    whatCharacterPressed = "girl"
    }
    
    @IBAction func BoyPressed(_ sender: UIButton) {
    
      Charactervalidation.isHidden = true
      isPressed = true
        girl.backgroundColor = UIColor.white
        boy.backgroundColor = UIColor.lightGray
//      boy.isHidden = true
      print("Boy pressed")
      whatCharacterPressed = "boy"
    }
    
    
    @IBAction func CreateAccountButton(_ sender: UIButton) {
        self.tabBarController?.tabBar.isHidden = true
        CharacterNamevalidation.isHidden = true
        
//        if (Character == "girl"){
//         selectedImage.image = UIImage(named:"girl.png")
//         }else if (Character == "boy"){
//         selectedImage.image = UIImage(named:"boy.png")
//         }else{
//             selectedImage.image = UIImage(named:"LOGO")
//         }
//        ___________________________________________________________________
//        if (Global.shared.usercharacter == "girl"){
//        let imageName = "girl.png"
//        let image = UIImage(named: imageName)
//        let imageView = UIImageView(image: image!)
//        imageView.frame = CGRect(x: 293, y: 700, width: 246, height: 210)
//        view.addSubview(imageView)
//        }else if (Global.shared.usercharacter == "boy"){
//            let imageName = "boy.png"
//            let image = UIImage(named: imageName)
//            let imageView = UIImageView(image: image!)
//            imageView.frame = CGRect(x: 293, y: 700, width: 246, height: 210)
//            view.addSubview(imageView)
//        }
//        ___________________________________________________________________

               let validationResult = isValidName()
               if validationResult.0 == false {return}
       
               let name = validationResult.1
       
               CharacterName = name
               Global.shared.usercharacterName = name
               print("CharacterName : " , CharacterName)
        
        
               
               print("Global email : " , Global.shared.useremailshare )
               print("Global password : ", Global.shared.userpasswordshare )
               print("Global birthday : ", Global.shared.userbirthday )
               print(" Global character : " , Global.shared.usercharacter)
               print("Global character name : " , Global.shared.usercharacterName)
         
        
        self.storeUserInformation()


         
        Auth.auth().createUser(withEmail: Global.shared.useremailshare, password: Global.shared.userpasswordshare) { authResult , error in
        if let e = error {
        print(e.localizedDescription)
        }else {
        // Go to our home screen
        self.performSegue(withIdentifier: "goToHomePage", sender: self)
           }
        }
        
    }
    
    
    
    
    
    func isValidName() -> (Bool, String, String) {
        
        guard let Name = nameTextField.text?.trimmingCharacters(in: .whitespaces).lowercased() , !Name.isEmpty
        else {
            CharacterNamevalidation.isHidden = false
            CharacterNamevalidation.text = "الرجاء إدخال اسم الشخصية"
            return (false, "", "")
           }
        if !isValidCharacterName(nameText: Name) {
            CharacterNamevalidation.isHidden = false
            CharacterNamevalidation.text = "الرجاء إدخال اسم شخصية صحيح"
            return (false, "", "")
        }
        return (true, Name , "")
    }
    
    
    func isValidCharacterName(nameText:String) -> Bool {
        
        let NameRegEx = "\\w{3,18}"
        let NameTest = NSPredicate(format:"SELF MATCHES %@", NameRegEx)
        return NameTest.evaluate(with: nameText)
    }
    
    
    
    
    func isValidbod() -> (Bool, String, String) {
        
        guard let birthday = bithdayTextField.text?.trimmingCharacters(in: .whitespaces).lowercased() , !birthday.isEmpty
        else {
            Birthdayvalidation.isHidden = false
            Birthdayvalidation.text = "الرجاء إدخال تاريخ الميلاد"
            return (false, "", "")
           }
        if !isValidBirthday(BirthdayText: birthday) {
            Birthdayvalidation.isHidden = false
            Birthdayvalidation.text = "الرجاء إدخال تاريخ الميلاد بالشكل الصحيح"
            return (false, "", "")
        }
        return (true, birthday , "")
    }
    
    
    func isValidBirthday(BirthdayText:String) -> Bool {
        
        let BoDRegEx = "^(0[1-9]|[12][0-9]|3[01])[- \\.](0[1-9]|1[012])[- \\.](19|20)\\d\\d$"
        let BoDTest = NSPredicate(format:"SELF MATCHES %@", BoDRegEx)
        return BoDTest.evaluate(with: BirthdayText)
    }
    
    
    func isValidEmailR(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
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
    
    
    
    
//    func storeUserInformation(collection: String, data: [String: Any]) async {
//
//        let db = Firestore.firestore()
//        do {
//            try await db.collection(collection).document().setData(data)
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
    
    func storeUserInformation()  {
            
            let post = ["email": Global.shared.useremailshare,
                        "password": Global.shared.userpasswordshare,
                        "dob": Global.shared.userbirthday,
                        "character": Global.shared.usercharacter,
                        "name": Global.shared.usercharacterName]
            
            let db = Firestore.firestore()
                   do {
                    try db.collection("Child").document().setData(post)
                   } catch {
                       print(error.localizedDescription)
                   }
        print("add the user into the firebafe firestore")
        }
    
    
    
    
    
//    @IBAction func CreateAccountPressed(_ sender: UIButton) {
//
////        guard let email = emailTextField.text else {return}
////        guard let password = passwordTextField.text else {return}
////            Auth.auth().createUser(withEmail: email, password: password) { authResult , error in
////                if let e = error {
////                    print(e.localizedDescription)
////                   }else {
////                     // Go to our home screen
////                    self.performSegue(withIdentifier: "goToNext", sender: self)
////                }
////            }
//        }
  
    

    
}



