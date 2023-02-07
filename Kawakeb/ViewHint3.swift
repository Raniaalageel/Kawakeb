//
//  ViewHint3.swift
//  Kawakeb
//
//  Created by Modhy Abduallh on 11/07/1444 AH.

import UIKit
import CodableFirebase
import Firebase
import FirebaseFirestore

class ViewHint3: UIViewController {

    
    @IBOutlet weak var hint13: UIView!
    @IBOutlet weak var hint23: UIView!
    //@IBOutlet weak var hint33: UIView!
    
    @IBOutlet weak var hint43: UIView!
    @IBOutlet weak var hint53: UIView!
    @IBOutlet weak var hint63: UIView!
    @IBOutlet weak var hint33: UIView!
    
    @IBOutlet weak var front31: UIImageView!
    @IBOutlet weak var back31: UIImageView!
    
    @IBOutlet weak var front32: UIImageView!
    @IBOutlet weak var back32: UIImageView!
    
    @IBOutlet weak var back33: UIImageView!
    @IBOutlet weak var front33: UIImageView!
    
    @IBOutlet weak var front34: UIImageView!
    @IBOutlet weak var back34: UIImageView!
    
    @IBOutlet weak var back35: UIImageView!
    @IBOutlet weak var front35: UIImageView!
    
    @IBOutlet weak var back36: UIImageView!
    @IBOutlet weak var front36: UIImageView!

    var isSelected = false
    var hintIsView = false
    static var selectedHint = Int()

    @IBOutlet weak var hint: UIButton!
    
    @IBOutlet weak var dire: UIButton!
    @IBOutlet weak var bac: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        hint.layer.cornerRadius =       hint.frame.width/2
         hint.layer.borderWidth = 6
        hint.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
         hint.clipsToBounds = true
        
        
      dire.layer.cornerRadius =        dire.frame.width/2
        dire.layer.borderWidth = 6
        dire.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        dire.clipsToBounds = true
        
        
       bac.layer.cornerRadius =      bac.frame.width/2
        bac.layer.borderWidth = 6
        bac.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        bac.clipsToBounds = true
        
        
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

                                "ThirdGameHintIsUsed": false ,

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
            hintIsView = snapshot.documents.first?.data()["ThirdGameHintIsUsed"] as! Bool
            if hintIsView == false {
                hint13.isUserInteractionEnabled = true
                hint23.isUserInteractionEnabled = true
                hint33.isUserInteractionEnabled = true
                hint43.isUserInteractionEnabled = true
                hint53.isUserInteractionEnabled = true
              //  hint63.isUserInteractionEnabled = true
                
                hint13.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hint31Flip)))
                hint23.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hint32Flip)))
                hint33.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hint33Flip)))
                hint43.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hint34Flip)))
                hint53.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hint35Flip)))
//                hint63.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hint36Flip)))
            } else {
                if ViewHint.selectedHint == 1 {
                    hint31Flip()
                }
                else if ViewHint.selectedHint == 2 {
                    hint32Flip()
                }
                else if ViewHint.selectedHint == 3 {
                    hint33Flip()
                }
               else if ViewHint.selectedHint == 4 {
                    hint34Flip()
                }
                else if ViewHint.selectedHint == 5 {
                     hint35Flip()
                 }
//                else if ViewHint.selectedHint == 6 {
//                     hint36Flip()
//                 }
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
                                "ThirdGameHintIsUsed": true
                                ])
                        }
                    }
      }
    }
    
    @objc func hint31Flip() {
        if isSelected == false {
            UIView.transition(from: front31, to: back31, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews])
        }
        isSelected = true
       // FirstGame.isUsed = true
        hintIsView = true
        ViewHint.selectedHint = 1
        hint13.isUserInteractionEnabled = false
        hint23.isUserInteractionEnabled = false
        hint33.isUserInteractionEnabled = false
        hint43.isUserInteractionEnabled = false
        hint53.isUserInteractionEnabled = false
        //hint63.isUserInteractionEnabled = false
    }
    
    @objc func hint32Flip() {
        if isSelected == false {
            UIView.transition(from: front32, to: back32, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews])
        }
        isSelected = true
       // FirstGame.isUsed = true
        hintIsView = true
        ViewHint.selectedHint = 2
        hint13.isUserInteractionEnabled = false
        hint23.isUserInteractionEnabled = false
        hint33.isUserInteractionEnabled = false
        hint43.isUserInteractionEnabled = false
        hint53.isUserInteractionEnabled = false
       // hint63.isUserInteractionEnabled = false
    }
    
    @objc func hint33Flip() {
        if isSelected == false {
            UIView.transition(from: front33, to: back33, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews])
        }
        isSelected = true
      //  FirstGame.isUsed = true
        hintIsView = true
        ViewHint.selectedHint = 3
        hint13.isUserInteractionEnabled = false
        hint23.isUserInteractionEnabled = false
        hint33.isUserInteractionEnabled = false
        hint43.isUserInteractionEnabled = false
        hint53.isUserInteractionEnabled = false
      //  hint63.isUserInteractionEnabled = false
    }
    
    @objc func hint34Flip() {
        if isSelected == false {
            UIView.transition(from: front34, to: back34, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews])
        }
        isSelected = true
      //  FirstGame.isUsed = true
        hintIsView = true
        ViewHint.selectedHint = 4
        hint13.isUserInteractionEnabled = false
        hint23.isUserInteractionEnabled = false
        hint33.isUserInteractionEnabled = false
        hint43.isUserInteractionEnabled = false
        hint53.isUserInteractionEnabled = false
       // hint63.isUserInteractionEnabled = false
    }
    
    @objc func hint35Flip() {
        if isSelected == false {
            UIView.transition(from: front35, to: back35, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews])
        }
        isSelected = true
      //  FirstGame.isUsed = true
        hintIsView = true
        ViewHint.selectedHint = 5
        hint13.isUserInteractionEnabled = false
        hint23.isUserInteractionEnabled = false
        hint33.isUserInteractionEnabled = false
        hint43.isUserInteractionEnabled = false
        hint53.isUserInteractionEnabled = false
        //hint63.isUserInteractionEnabled = false
    }
    
//    @objc func hint36Flip() {
//        if isSelected == false {
//            UIView.transition(from: front36, to: back36, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews])
//        }
//        isSelected = true
//      //  FirstGame.isUsed = true
//        hintIsView = true
//        ViewHint.selectedHint = 6
//        hint13.isUserInteractionEnabled = false
//        hint23.isUserInteractionEnabled = false
//        hint33.isUserInteractionEnabled = false
//        hint43.isUserInteractionEnabled = false
//        hint53.isUserInteractionEnabled = false
//        hint63.isUserInteractionEnabled = false
//    }

    
}

