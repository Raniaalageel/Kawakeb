//
//  ViewHint.swift
//  Kawakeb
//
//  Created by Modhy Abduallh on 24/06/1444 AH.
//

import UIKit
import CodableFirebase
import Firebase
import FirebaseFirestore

class ViewHint : UIViewController {
    
    @IBOutlet weak var hint1BackImage: UIImageView!
    @IBOutlet weak var hint2BackImage: UIImageView!
    @IBOutlet weak var hint3BackImage: UIImageView!
    @IBOutlet weak var hint4BackImage: UIImageView!
    
    @IBOutlet weak var hint1FrontImage: UIImageView!
    @IBOutlet weak var hint2FrontImage: UIImageView!
    @IBOutlet weak var hint4FrontImage: UIImageView!
    @IBOutlet weak var hint3FrontImage: UIImageView!
    
    @IBOutlet weak var hint1: UIView!
    @IBOutlet weak var hint2: UIView!
    @IBOutlet weak var hint3: UIView!
    @IBOutlet weak var hint4: UIView!
    
    var isSelected = false
    var hintIsView = false
    static var selectedHint = Int()
    
    @IBOutlet weak var bac: UIButton!
    
    @IBOutlet weak var direc: UIButton!
   
    @IBOutlet weak var hint: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     hint.layer.cornerRadius =       hint.frame.width/2
      hint.layer.borderWidth = 6
     hint.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
      hint.clipsToBounds = true
        
        
       bac.layer.cornerRadius =       bac.frame.width/2
      bac.layer.borderWidth = 6
        bac.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
       bac.clipsToBounds = true
        
        
        
        direc.layer.cornerRadius =       direc.frame.width/2
        direc.layer.borderWidth = 6
        direc.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        direc.clipsToBounds = true
        
        sethint()
        hintIsVieww()
    }
    
    
    
    func sethint()
    {
        let db = Firestore.firestore()
        let sharedEmail = Global.shared.useremailshare

                        Task {
                            db.collection("Child").whereField("email", isEqualTo:sharedEmail).getDocuments{
                                (snapshot, error) in
                                if let error = error {
                                    print("FAIL ")
                                }
                                else{
                                    print("SUCCESS??")
                                   }
                            }
                            guard let id = try await db.collection("Child").whereField("email", isEqualTo: sharedEmail ).getDocuments().documents.first?.documentID else {
                             return
                            }
                            print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh")

                            try await db.collection("Child").document(id).setData([

                                "FirstGameHintIsUsed": false ,

                            ],merge: true) { err in
                                if let err = err {
                                    print("Error   : \(err)")
                                } else {
                                    print("add ")
                                }
                            }
                            }
            }

    func hintIsVieww () {
        let db = Firestore.firestore()
        Task {
        let snapshot = try await db.collection("Child").whereField("email", isEqualTo: Global.shared.useremailshare).getDocuments()
            hintIsView = snapshot.documents.first?.data()["FirstGameHintIsUsed"] as! Bool
            if hintIsView == false {
                hint1.isUserInteractionEnabled = true
                hint2.isUserInteractionEnabled = true
                hint3.isUserInteractionEnabled = true
                hint4.isUserInteractionEnabled = true
                
                hint1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hint1Flip)))
                hint2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hint2Flip)))
                hint3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hint3Flip)))
                hint4.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hint4Flip)))
            } else {
                if ViewHint.selectedHint == 1 {
                    hint1Flip()
                }
                else if ViewHint.selectedHint == 2 {
                    hint2Flip()
                }
                else if ViewHint.selectedHint == 3 {
                    hint3Flip()
                }
               else if ViewHint.selectedHint == 4 {
                    hint4Flip()
                }
            }
              guard let id = try await db.collection("Child").whereField("email", isEqualTo: Global.shared.useremailshare ).getDocuments().documents.first?.documentID else {
                        return
                        }
                    let updateReference = db.collection("Child").document(id)
                    updateReference.getDocument { (document, err) in
                        if let err = err {
                            print(err.localizedDescription)
                        }
                        else {
                            document?.reference.updateData([
                                "FirstGameHintIsUsed": true
                                ])
                        }
                    }
      }
    }
    
    
    
    @objc func hint1Flip() {
        if isSelected == false {
            UIView.transition(from: hint1FrontImage, to: hint1BackImage, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews])
        }
        isSelected = true
       // FirstGame.isUsed = true
        hintIsView = true
        ViewHint.selectedHint = 1
        hint1.isUserInteractionEnabled = false
        hint2.isUserInteractionEnabled = false
        hint3.isUserInteractionEnabled = false
        hint4.isUserInteractionEnabled = false
    }
    
    @objc func hint2Flip() {
        if isSelected == false {
            UIView.transition(from: hint2FrontImage, to: hint2BackImage, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews])
        }
        isSelected = true
       // FirstGame.isUsed = true
        hintIsView = true
        ViewHint.selectedHint = 2
        hint1.isUserInteractionEnabled = false
        hint2.isUserInteractionEnabled = false
        hint3.isUserInteractionEnabled = false
        hint4.isUserInteractionEnabled = false
    }
    
    @objc func hint3Flip() {
        if isSelected == false {
            UIView.transition(from: hint3FrontImage, to: hint3BackImage, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews])
        }
        isSelected = true
      //  FirstGame.isUsed = true
        hintIsView = true
        ViewHint.selectedHint = 3
        hint1.isUserInteractionEnabled = false
        hint2.isUserInteractionEnabled = false
        hint3.isUserInteractionEnabled = false
        hint4.isUserInteractionEnabled = false
    }
    
    @objc func hint4Flip() {
        if isSelected == false {
            UIView.transition(from: hint4FrontImage, to: hint4BackImage, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews])
        }
        isSelected = true
      //  FirstGame.isUsed = true
        hintIsView = true
        ViewHint.selectedHint = 4
        hint1.isUserInteractionEnabled = false
        hint2.isUserInteractionEnabled = false
        hint3.isUserInteractionEnabled = false
        hint4.isUserInteractionEnabled = false
    }
}
