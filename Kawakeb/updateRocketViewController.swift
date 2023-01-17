//
//  updateRocketViewController.swift
//  Kawakeb
//
//  Created by SHAMMA  on 21/06/1444 AH.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
var Uimage:UIImageView = UIImageView()
var Uname:String=""
var IMGname = ""

class updateRocketViewController: UIViewController {
    var curR = ""
    @IBOutlet weak var cancelBTN: UIButton!
    @IBOutlet weak var newName: UILabel!
    @IBOutlet weak var newRoc: UIImageView!
    var nameIMG = ""
    override func viewDidLoad() {
    
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "firstbg.png")!)
        newRoc.image = Uimage.image
        view.addSubview(newRoc)
        newName.text = Uname
        nameIMG = IMGname
        
       
      
        // Do any additional setup after loading the view.
    }
  
  
    @IBAction func changeRocket(_ sender: Any) {
        let db = Firestore.firestore()
        
   
                
                Task{
                    db.collection("Child").whereField("email", isEqualTo: Global.shared.useremailshare).getDocuments{
                        (snapshot, error) in
                        if let error = error {
                            print("FAIL ")
                        }
                        else{
                            print("SUCCESS??")
                       let myROCK = snapshot!.documents.first!.get("currentRocket") as! String
                            
                            //let myrockets1 = snapshot!.documents.first!.get("rockets") as! [String]
                            //  guard let name1  = doc.get("name") as? String else { continue }
                           // self.myrockets = snapshot!.documents.first!.get("rockets") as! [String]
                         //   self.semster  = snapshot!.documents.first!.get("Semster") as! String
                            self.curR = myROCK
                            //self.myrocketsS.append(contentsOf: myrockets1)
                            
                      
                            print("my curR",self.curR)
                           
                          //  print("semster:", self.semster)

                   
                }
                        
                   
                    }
                    
                    guard let id = try await db.collection("Child").whereField("email", isEqualTo: Global.shared.useremailshare).getDocuments().documents.first?.documentID else {
                 
                        return
                    }
                       
          
                    try await db.collection("Child").document(id).setData([
          
                        "currentRocket":newName.text,
                        "currentRockIMG":nameIMG
                    //  "rockets":myrocketsS.append(Sname)
          
          
                    ],merge: true) { err in
                        if let err = err {
                            print("Error   : \(err)")
                        } else {
                            print("add ")
                            
                     
                        }
          
                    }
                  
                    }
                
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
