//
//  StoreVC.swift
//  Kawakeb
//
//  Created by SHAMMA  on 02/06/1444 AH.
//



import UIKit
import FirebaseFirestore
import FirebaseStorage
class StoreVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var names = [String]()
    var prices = [Int]()
    var myrockets = [String]()
    var points = Int()
    var photo = [String]()
    var imageView = UIImageView()
    @IBOutlet weak var StoretableView: UITableView!
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        StoretableView.delegate = self
        StoretableView.dataSource = self
        
        
        
        
        let db = Firestore.firestore()
        
   
                
                
                
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
                        self.points = points1
                        self.myrockets.append(contentsOf: myrockets1)
                        print("names",self.names)
                        
                        print("names.count",self.names.count)
                        
                        print("myrockets",self.myrockets)
                        print("my points",self.points)
                       
                      //  print("semster:", self.semster)

                        self.StoretableView.reloadData()
            }
                }
                
            
        
        
        db.collection("Rockets").getDocuments(){ [self](snapshot, error) in
            if let error = error {
                print("FAIL ")
            }
            else{
                
                
                
                for doc in snapshot!.documents {
                    
                    
                    
                    
                    guard let name1  = doc.get("name") as? String else { continue }
                    guard let price1  = doc.get("price") as? Int else { continue }
                    guard let photo1  = doc.get("image") as? String else { continue }
                    
                    
                    print("name1",name1)
                    print("price1",price1)
                    
                    
                    
                    
                    self.prices.append(price1)
                    self.names.append(name1)
                    self.photo.append(photo1)
                }
                
                
                
                
                
    }
           
                //
                self.StoretableView.reloadData()}
                //  let a_snapshot = try await db.collection("Child").wherefgetDocuments()
               
        
    }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 170 //Choose your custom row height
        }
        
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
           
            return names.count
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            print("enter??")
            let mycell = tableView.dequeueReusableCell (withIdentifier: "rocketCell", for: indexPath) as! storeCell
            
            mycell.rocketName.text? = names[indexPath.row]
            print(" my.rocketName.text = names[indexPath.row]",names[indexPath.row])
            if(prices[indexPath.row] < 11){
                mycell.rocketPrice.text? = String (prices[indexPath.row])
                mycell.rocketPrice.text? += " نجوم"
            }
            else{
                mycell.rocketPrice.text? = String (prices[indexPath.row])
                mycell.rocketPrice.text? += " نجمة "
            }
         
           // mycell.rocketImage.image =
            if myrockets.contains(names[indexPath.row]) {
                print("you have it ")
                mycell.rocketBtn.setTitle("استبدل", for: .normal)
                mycell.rocketBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                mycell.rocketBtn.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                mycell.lockIMG.isHidden = true
                mycell.rocketImage.alpha = 1
                mycell.rocketBtn.layer.cornerRadius = 20
                mycell.rocketBtn.setTitleColor( #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) , for: .normal)
            }
            else if(points >= prices[indexPath.row]){ //can buy
                mycell.rocketBtn.setTitle("شراء", for: .normal)
                mycell.rocketBtn.backgroundColor =  #colorLiteral(red: 0.8993717432, green: 0.3597564697, blue: 0.2627948225, alpha: 1)
                mycell.rocketImage.alpha = 1
                mycell.rocketBtn.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                mycell.lockIMG.isHidden = true
                mycell.rocketBtn.layer.cornerRadius = 20
             mycell.rocketBtn.setTitleColor( #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) , for: .normal)
            }
            else {//can not buy
                mycell.rocketBtn.setTitle("شراء", for: .normal)
                mycell.rocketBtn.backgroundColor =  #colorLiteral(red: 0.8993717432, green: 0.3597564697, blue: 0.2627948225, alpha: 1)
                mycell.rocketBtn.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
             
                mycell.rocketBtn.setTitleColor( #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
                mycell.rocketImage.alpha = 0.5
                mycell.lockIMG.isHidden = false
                mycell.rocketBtn.layer.cornerRadius = 20
            }
            let storageRef = Storage.storage().reference()
               let photoRef = storageRef.child(photo[indexPath.row])
           // let imageView: UIImageView = self.imageView
          //  mycell.rocketImage.sd_setImage(with: photoRef)
          //  mycell.rocketImage.UIImage(with: photoRef)
              
        //    mycell.rocketImage.image =  UIImage(named: photoRef)
         mycell.rocketImage.image = UIImage(named: photo[indexPath.row])
    
            return mycell
            
        }
    }
    

