//
//  StoreVC.swift
//  Kawakeb
//
//  Created by SHAMMA  on 02/06/1444 AH.
//



import UIKit
import FirebaseFirestore
class StoreVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
  
  
    @IBOutlet weak var StoretableView: UITableView!
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0 //Choose your custom row height
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        
        return names.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("s")
        let my = tableView.dequeueReusableCell (withIdentifier: "rocketCell", for: indexPath) as! storeCell
        
        my.rocketName.text? = names[indexPath.row]
        print(" my.rocketName.text = names[indexPath.row]",names[indexPath.row])
        
        
      
        
        
        my.rocketPrice.text? = prices[indexPath.row]
        return my
        
    }
    
    var names = [String]()
    var prices = [String]()
   
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        //        let date = Date()
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = " EEEE, MMM d, yyyy‏"
        //       dataUi.text = dateFormatter.string(from: date)
        //    semester.text = semster
        //
        StoretableView.delegate = self
        StoretableView.dataSource = self
        
        
        
        //   get()snapshot?.documents.forEach({ (document) in
        let db = Firestore.firestore()
        
        
        
        Task {
            
            let t_snapshot = try await db.collection("Rockets").getDocuments()
            
            // dateAll.removeAll()
            
            for doc in t_snapshot.documents {
                let documentID = doc.documentID
                
                //      let st = t_snapshot.documents.first?.data()["st"] as! String
                
                guard let name1  = doc.get("name") as? String else { continue }
                
                guard let price1  = doc.get("price") as? String else { continue }
                
                print("state of student/",name1)
                
                
                
                print("time of student/",price1)
                
                
                
                
                prices.append(price1)
                names.append(name1)
                
                
            }
            
            
            print("names",names)
      
            print("names.count",names.count)
            
        }

        
   
        
    }
}
        
