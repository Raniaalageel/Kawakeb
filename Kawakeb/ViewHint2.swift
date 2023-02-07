//  ViewHint2.swift
//  Kawakeb
//
//  Created by Modhy Abduallh on 10/07/1444 AH.
//

import UIKit
import CodableFirebase
import Firebase
import FirebaseFirestore

class ViewHint2: UIViewController {

    
    @IBOutlet weak var front2: UIImageView!
    @IBOutlet weak var back2: UIImageView!
    
    
    @IBOutlet weak var front22: UIImageView!
    @IBOutlet weak var back22: UIImageView!
    
    @IBOutlet weak var front23: UIImageView!
    @IBOutlet weak var back23: UIImageView!
    
    @IBOutlet weak var front24: UIImageView!
    @IBOutlet weak var back24: UIImageView!
    
    @IBOutlet weak var front25: UIImageView!
    @IBOutlet weak var back25: UIImageView!
    
    
    @IBOutlet weak var hint12: UIView!
    @IBOutlet weak var hint22: UIView!
    @IBOutlet weak var hint32: UIView!
    @IBOutlet weak var hint42: UIView!
    @IBOutlet weak var hint52: UIView!
    
    @IBOutlet weak var bac: UIButton!
    
    @IBOutlet weak var dire: UIButton!
    
    @IBOutlet weak var hint: UIButton!
    
    
    var isSelected = false
    var hintIsView = false
    static var selectedHint = Int()

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

                                "SecondGameHintIsUsed": false ,

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
            hintIsView = snapshot.documents.first?.data()["SecondGameHintIsUsed"] as! Bool
            if hintIsView == false {
                hint12.isUserInteractionEnabled = true
                hint22.isUserInteractionEnabled = true
                hint32.isUserInteractionEnabled = true
                hint42.isUserInteractionEnabled = true
                hint52.isUserInteractionEnabled = true
                
                hint12.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hint21Flip)))
                hint22.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hint22Flip)))
                hint32.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hint32Flip)))
                hint42.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hint42Flip)))
                hint52.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hint52Flip)))
            } else {
                if ViewHint.selectedHint == 1 {
                    hint21Flip()
                }
                else if ViewHint.selectedHint == 2 {
                    hint22Flip()
                }
                else if ViewHint.selectedHint == 3 {
                    hint32Flip()
                }
               else if ViewHint.selectedHint == 4 {
                    hint42Flip()
                }
                else if ViewHint.selectedHint == 5 {
                     hint52Flip()
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
                                "SecondGameHintIsUsed": true
                                ])
                        }
                    }
      }
    }
    
    
    
    @objc func hint21Flip() {
        if isSelected == false {
            UIView.transition(from: front2, to: back2, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews])
        }
        isSelected = true
       // FirstGame.isUsed = true
        hintIsView = true
        ViewHint.selectedHint = 1
        hint12.isUserInteractionEnabled = false
        hint22.isUserInteractionEnabled = false
        hint32.isUserInteractionEnabled = false
        hint42.isUserInteractionEnabled = false
        hint52.isUserInteractionEnabled = false
    }
    
    @objc func hint22Flip() {
        if isSelected == false {
            UIView.transition(from: front22, to: back22, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews])
        }
        isSelected = true
       // FirstGame.isUsed = true
        hintIsView = true
        ViewHint.selectedHint = 2
        hint12.isUserInteractionEnabled = false
        hint22.isUserInteractionEnabled = false
        hint32.isUserInteractionEnabled = false
        hint42.isUserInteractionEnabled = false
        hint52.isUserInteractionEnabled = false
    }
    
    @objc func hint32Flip() {
        if isSelected == false {
            UIView.transition(from: front23, to: back23, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews])
        }
        isSelected = true
      //  FirstGame.isUsed = true
        hintIsView = true
        ViewHint.selectedHint = 3
        hint12.isUserInteractionEnabled = false
        hint22.isUserInteractionEnabled = false
        hint32.isUserInteractionEnabled = false
        hint42.isUserInteractionEnabled = false
        hint52.isUserInteractionEnabled = false
    }
    
    @objc func hint42Flip() {
        if isSelected == false {
            UIView.transition(from: front24, to: back24, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews])
        }
        isSelected = true
      //  FirstGame.isUsed = true
        hintIsView = true
        ViewHint.selectedHint = 4
        hint12.isUserInteractionEnabled = false
        hint22.isUserInteractionEnabled = false
        hint32.isUserInteractionEnabled = false
        hint42.isUserInteractionEnabled = false
        hint52.isUserInteractionEnabled = false
    }
    
    @objc func hint52Flip() {
        if isSelected == false {
            UIView.transition(from: front25, to: back25, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews])
        }
        isSelected = true
      //  FirstGame.isUsed = true
        hintIsView = true
        ViewHint.selectedHint = 5
        hint12.isUserInteractionEnabled = false
        hint22.isUserInteractionEnabled = false
        hint32.isUserInteractionEnabled = false
        hint42.isUserInteractionEnabled = false
        hint52.isUserInteractionEnabled = false
    }
}

