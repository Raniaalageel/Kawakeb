//
//  RocketViewController.swift
//  Kawakeb
//
//  Created by SHAMMA  on 20/06/1444 AH.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
var Simage:UIImageView = UIImageView()
var Sname:String=""
var Sprice:Int=0
var realPrice :Int=0

class RocketViewController: UIViewController {
    var pointss:Int=0
    var myrocketsS = [String]()
    @IBOutlet weak var selectedIMG: UIImageView!
    
    
    @IBOutlet weak var selectedName: UILabel!
    
    @IBOutlet weak var selectedPrice: UILabel!
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "firstbg.png")!)
        selectedIMG.image = Simage.image
        view.addSubview(selectedIMG)
        selectedName.text = Sname
        selectedPrice.text = String(Sprice)
        realPrice = Sprice
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func buyRocket(_ sender: Any) {
        
        let db = Firestore.firestore()
        
   
                
                Task{
                    db.collection("Child").whereField("email", isEqualTo: "shamma@gmail.com").getDocuments{
                        (snapshot, error) in
                        if let error = error {
                            print("FAIL ")
                        }
                        else{
                            print("SUCCESS??")
                       let points1 = snapshot!.documents.first!.get("points") as! Int
                            
                            let myrockets1 = snapshot!.documents.first!.get("rockets") as! [String]
                            //  guard let name1  = doc.get("name") as? String else { continue }
                           // self.myrockets = snapshot!.documents.first!.get("rockets") as! [String]
                         //   self.semster  = snapshot!.documents.first!.get("Semster") as! String
                            self.pointss = points1
                            self.myrocketsS.append(contentsOf: myrockets1)
                            
                      
                            print("my points",self.pointss)
                           
                          //  print("semster:", self.semster)

                   
                }
                        
                   
                    }
                    
                    guard let id = try await db.collection("Child").whereField("email", isEqualTo: "shamma@gmail.com").getDocuments().documents.first?.documentID else {
                 
                        return
                    }
                       
          
                    try await db.collection("Child").document(id).setData([
          
                      "points": (pointss-realPrice) ,
                    //  "rockets":myrocketsS.append(Sname)
          
          
                    ],merge: true) { err in
                        if let err = err {
                            print("Error   : \(err)")
                        } else {
                            print("add ")
                        }
          
                    }
                    try await db.collection("Child").document(id).updateData([
                        "rockets": FieldValue.arrayUnion([Sname])
                        
                    ])
               
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
