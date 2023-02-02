//
//  ViewHint3.swift
//  Kawakeb
//
//  Created by Modhy Abduallh on 11/07/1444 AH.
//

import UIKit
import CodableFirebase
import Firebase
import FirebaseFirestore

class ViewHint3: UIViewController {

    
    var isSelected = false
    var hintIsView = false
    static var selectedHint = Int()

    
    override func viewDidLoad() {
        super.viewDidLoad()
       // sethint()
       // hintIsVieww()
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
    
}
