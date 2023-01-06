//
//  ViewHint.swift
//  Kawakeb
//
//  Created by Modhy Abduallh on 12/06/1444 AH.
//

import UIKit

class ViewHint : UIViewController {
    
    @IBOutlet weak var hint1BackImage: UIImageView!
    @IBOutlet weak var hint2BackImage: UIImageView!
    @IBOutlet weak var hint3BackImage: UIImageView!
    @IBOutlet weak var hint4BackImage: UIImageView!
   
    @IBOutlet weak var hint1FrontImage: UIImageView!
    @IBOutlet weak var hint2FrontImage: UIImageView!
    @IBOutlet weak var hint3FrontImage: UIImageView!
    @IBOutlet weak var hint4FrontImage: UIImageView!
    
    @IBOutlet weak var hint1: UIView!
    @IBOutlet weak var hint2: UIView!
    @IBOutlet weak var hint3: UIView!
    @IBOutlet weak var hint4: UIView!
    
    var isSelected = false
    
    static var selectedHint = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if FirstGame.isUsed == false {
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
            if ViewHint.selectedHint == 2 {
                hint2Flip()
            }
            if ViewHint.selectedHint == 3 {
                hint3Flip()
            }
            if ViewHint.selectedHint == 4 {
                hint4Flip()
            }
        }
        
        
        
    }
    
    
    @objc func hint1Flip() {
        if isSelected == false {
            UIView.transition(from: hint1FrontImage, to: hint1BackImage, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews])
        }
        isSelected = true
        FirstGame.isUsed = true
        ViewHint.selectedHint = 1
    }
    
    @objc func hint2Flip() {
        if isSelected == false {
            UIView.transition(from: hint2FrontImage, to: hint2BackImage, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews])
        }
        isSelected = true
        FirstGame.isUsed = true
        ViewHint.selectedHint = 2
    }
    
    @objc func hint3Flip() {
        if isSelected == false {
            UIView.transition(from: hint3FrontImage, to: hint3BackImage, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews])
        }
        isSelected = true
        FirstGame.isUsed = true
        ViewHint.selectedHint = 3
    }
    
    @objc func hint4Flip() {
        if isSelected == false {
            UIView.transition(from: hint4FrontImage, to: hint4BackImage, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews])
        }
        isSelected = true
        FirstGame.isUsed = true
        ViewHint.selectedHint = 4
    }

}
