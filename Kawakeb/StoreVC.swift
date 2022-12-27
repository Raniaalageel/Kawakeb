//
//  StoreVC.swift
//  Kawakeb
//
//  Created by SHAMMA  on 02/06/1444 AH.
//



import UIKit
import FirebaseFirestore
class StoreVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var names = [String]()
    var prices = [Int]()
    var myrockets = [String]()
    var points = Int()
    
    @IBOutlet weak var StoretableView: UITableView!
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        StoretableView.delegate = self
        StoretableView.dataSource = self
        
        
        
        
        let db = Firestore.firestore()
        
        
        
        
        
        db.collection("Rockets").getDocuments(){ [self](snapshot, error) in
            if let error = error {
                print("FAIL ")
            }
            else{
                
                
                
                for doc in snapshot!.documents {
                   
                    
                    
                    
                    guard let name1  = doc.get("name") as? String else { continue }
                    guard let price1  = doc.get("price") as? Int else { continue }
                    
                    
                    print("name1",name1)
                    print("price1",price1)
                    
                    
                    
                    
                    self.prices.append(price1)
                    self.names.append(name1) }
                
                //  let a_snapshot = try await db.collection("Child").wherefgetDocuments()
                db.collection("Child").whereField("email", isEqualTo: Global.shared.useremailshare).getDocuments()
                { [self](snapshot, error) in
                    if let error = error {
                        print("FAIL ")
                    }
                    else{
                        
                        for doc in snapshot!.documents {
                            
                            
                            
                            
                            
                            guard let point1  = doc.get("points") as? Int else { continue }
                            guard let rocket1  = doc.get("rockets") as? [String] else { continue }
                            
                            
                            print("name1",point1)
                            print("price1",rocket1)
                            
                            
                            
                            
                            self.points = point1
                            self.myrockets.append(contentsOf: rocket1)
                            
                            //let a_snapshot = try await db.collection("Child").wherefgetDocuments()
                            
                        }
                        
                        
                        
                        
                        print("names",names)
                        
                        print("names.count",names.count)
                        
                        
                        
                    }
                    
                }
            }
        }
    }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100.0 //Choose your custom row height
        }
        
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            
            return names.count
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            print("enter??")
            let mycell = tableView.dequeueReusableCell (withIdentifier: "rocketCell", for: indexPath) as! storeCell
            
            mycell.rocketName.text? = names[indexPath.row]
            print(" my.rocketName.text = names[indexPath.row]",names[indexPath.row])
            mycell.rocketPrice.text? = String (prices[indexPath.row])
            if myrockets.contains(names[indexPath.row]) {
                print("you have it ")
                mycell.rocketBtn.setTitle("استبدل", for: .normal)
                mycell.rocketBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                mycell.rocketBtn.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            }
            else if(points >= prices[indexPath.row]){ //can buy
                mycell.rocketBtn.setTitle("شراء", for: .normal)
                mycell.rocketBtn.backgroundColor =  #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            }
            else if (points < prices[indexPath.row]){ //can not buy
                mycell.rocketBtn.setTitle("شراء", for: .disabled)
                mycell.rocketBtn.backgroundColor =  #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            }
            return mycell
            
        }
    }
    

