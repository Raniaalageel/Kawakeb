//
//  StoreVC.swift
//  Kawakeb
//
//  Created by SHAMMA  on 02/06/1444 AH.
//



import UIKit
import FirebaseFirestore
import FirebaseStorage
var btnName = ""
class StoreVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var names = [String]()
    var prices = [Int]()
    var myrockets = [String]()
    var points = Int()
    var photo = [String]()
    var imageView = UIImageView()
    var current = ""
    var tableArray = [Int]()
     var count = 0
    var a = ""
    var tableSorted = [(Int,String,String)]()
    var tableSorted2 = [(Int,String,String)]()
 
    @IBOutlet weak var StoretableView: UITableView!
    
    
    @IBOutlet weak var mypo: UILabel!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Global.shared.audioHomePage.pause()
        StoretableView.reloadData()
        
        StoretableView.delegate = self
        StoretableView.dataSource = self
        
        
        
        
        let db = Firestore.firestore()
        
   
                
                
                
                db.collection("Child").whereField("email", isEqualTo: Global.shared.useremailshare).getDocuments{
                    (snapshot, error) in
                    if let error = error {
                        print("FAIL ")
                    }
                    else{
                        print("SUCCESS??")
                   let points1 = snapshot!.documents.first!.get("points") as! Int
                        let formatter: NumberFormatter = NumberFormatter()
                        var  x1: Int!
                        x1 = snapshot!.documents.first!.get("points")  as! Int
                        var  a1 = NSNumber(value: x1)
                      formatter.locale = Locale(identifier: "ar")
                        self.a = formatter.string(from: a1)!
            let myrockets1 = snapshot!.documents.first!.get("rockets") as! [String]
                        let myROCK = snapshot!.documents.first!.get("currentRocket") as! String
                        //  guard let name1  = doc.get("name") as? String else { continue }
                       // self.myrockets = snapshot!.documents.first!.get("rockets") as! [String]
                     //   self.semster  = snapshot!.documents.first!.get("Semster") as! String
                        self.points = points1
                        self.myrockets.append(contentsOf: myrockets1)
                        self.current = myROCK
                        print("names",self.names)
                        
                        print("names.count",self.names.count)
                        
                        print("myrockets",self.myrockets)
                        print("my points",self.points)
                        
                        
                        self.mypo.text = self.a
                       
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
                    
                    //amani  start
               
                    var a = ""
                    let formatter: NumberFormatter = NumberFormatter()
                    var  x1: Int!
                    x1 = doc.get("price") as? Int
                    var  a1 = NSNumber(value: x1)
                  formatter.locale = Locale(identifier: "ar")
                   a = formatter.string(from: a1)!
                    //amani end
                    
                    print("name1",name1)
                    print("price1",price1)
                    print("ARABIC",a)
                    
                 //   self.arr.append(price1,name1,photo1)
                   
                    
                    self.prices.append(Int(a) ?? 0)
                    self.names.append(name1)
                    self.photo.append(photo1)
                    self.tableSorted.append(( prices[count], names[count], photo[count]))
                    count = count+1

                
                }
                
                
   
               
                
                
    }
           
                //
          
           
            tableSorted2 = tableSorted ?? [(0,"","")]
           let sortedArray1 = prices.sort { ($0 as Int) < ($1 as Int) }
            print("44######")
            print(sortedArray1)
        
         
            
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
      
        let (p, n, im) = tableSorted2[indexPath.row]
         
      
        
        mycell.rocketName.text? = names[indexPath.row]
        print(" my.rocketName.text = names[indexPath.row]",names[indexPath.row])
     
            mycell.rocketPrice.text? = String (prices[indexPath.row])
           
      
        
        // mycell.rocketImage.image =
        if myrockets.contains(names[indexPath.row]) {
            if (current == names[indexPath.row] ){
                
             
                mycell.currentBTN.isUserInteractionEnabled = false
                mycell.currentBTN.isHidden=false
                mycell.rocketBtn.isHidden=true
                mycell.updatebtn.isHidden=true
                mycell.lockIMG.isHidden = true
                mycell.rocketImage.alpha = 1

            }
            else{
                print("you have it ")
                mycell.rocketBtn.isHidden=true
                mycell.currentBTN.isHidden=true
                mycell.updatebtn.isHidden=false
                //mycell.updatebtn.setTitle("استبدل", for: .normal)
             //   mycell.updatebtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            //    mycell.updatebtn.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                mycell.lockIMG.isHidden = true
                mycell.rocketImage.alpha = 1
              //  mycell.updatebtn.layer.cornerRadius = 20
               // mycell.updatebtn.setTitleColor( #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) , for: .normal)
                mycell.updatebtn.isUserInteractionEnabled = true
            }
            
    
          

        }
        else if(points >= prices[indexPath.row]){ //can buy
            mycell.updatebtn.isHidden=true
            mycell.currentBTN.isHidden=true
            mycell.rocketBtn.isHidden=false
            
    
           // mycell.rocketBtn.backgroundColor =  #colorLiteral(red: 0.8993717432, green: 0.3597564697, blue: 0.2627948225, alpha: 1)
            mycell.rocketImage.alpha = 1
           // mycell.rocketBtn.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            mycell.lockIMG.isHidden = true
           // mycell.rocketBtn.layer.cornerRadius = 20
        //    mycell.rocketBtn.setTitleColor( #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) , for: .normal)
            mycell.rocketBtn.isUserInteractionEnabled = true

        }
        else {//can not buy
            mycell.updatebtn.isHidden=true
            mycell.rocketBtn.isHidden=false
            mycell.currentBTN.isHidden=true
         //   mycell.rocketBtn.backgroundColor =  #colorLiteral(red: 0.8993717432, green: 0.3597564697, blue: 0.2627948225, alpha: 1)
           // mycell.rocketBtn.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            
         //   mycell.rocketBtn.setTitleColor( #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
            mycell.rocketImage.alpha = 0.5
            mycell.lockIMG.isHidden = false
         //   mycell.rocketBtn.layer.cornerRadius = 20
            mycell.rocketBtn.isUserInteractionEnabled = false
        }
        let storageRef = Storage.storage().reference()
        let photoRef = storageRef.child(photo[indexPath.row])
        // let imageView: UIImageView = self.imageView
        //  mycell.rocketImage.sd_setImage(with: photoRef)
        //  mycell.rocketImage.UIImage(with: photoRef)
        
        //    mycell.rocketImage.image =  UIImage(named: photoRef)
        mycell.rocketImage.image = UIImage(named: photo[indexPath.row])
        mycell.rocketBtn.tag = indexPath.row
        mycell.updatebtn.tag = indexPath.row
        mycell.rocketBtn.addTarget(self, action: #selector(buyRocket (sender:)), for: .touchUpInside)
      
            mycell.updatebtn.addTarget(self, action: #selector(updateRocket  (sender:)), for: .touchUpInside)
            
       
          
            return mycell
            
        }
    @objc func buyRocket (sender:UIButton){
        let ind = IndexPath(row: sender.tag, section: 0)
        Sname = names[ind.row]
        Simage.image = UIImage(named: photo[ind.row])
        Sprice = prices[ind.row]
        let roc = self.storyboard?.instantiateViewController(withIdentifier: "RocketViewController") as! RocketViewController
        self.navigationController?.pushViewController(roc, animated: true)
        update()
    }
    
    @objc func updateRocket(sender: UIButton) {
        let ind = IndexPath(row: sender.tag, section: 0)
        Uname = names[ind.row]
        Uimage.image = UIImage(named: photo[ind.row])
        IMGname = photo[ind.row]
        let roc2 = self.storyboard?.instantiateViewController(withIdentifier: "updateRocketViewController") as! updateRocketViewController
        self.navigationController?.pushViewController(roc2, animated: true)
        update()
    }
   func update() {
         
               self.StoretableView.reloadData()
       //end
         
       }

    }
    

//var arr = [[AnyObject]]()
//
//let sortedArray1 = arr.sort { ($0[0] as? Int) < ($1[0] as? Int) }
//
//print(sortedArray1) // []
//
//arr = [[5, "test123"], [2, "test443"], [3, "test663"], [1, "test123"]]
//
//let sortedArray2 = arr.sort { ($0[0] as? Int) < ($1[0] as? Int) }
//
//print(sortedArray2)  // [[1, test123], [2, test443], [3, test663], [5, test123]]
//
