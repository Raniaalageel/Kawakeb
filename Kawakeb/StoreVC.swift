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
    @IBOutlet weak var pinnedIMG: UIImageView!
    @IBOutlet weak var pinnedTXT: UILabel!
    var points = Int()
    var photo = [String]()
    var allShop = [String]()
    var imageView = UIImageView()
    @IBOutlet weak var babtn: UIButton!
    var current = ""
    var currentimg = ""
    var tableArray = [Int]()
    var count = 0
    var a = ""
    @IBOutlet weak var PinnedRocket: UIView!
    var tableSorted = [(Int,String,String)]()
    var tableSorted2 = [(Int,String,String)]()
    
    @IBOutlet weak var StoretableView: UITableView!
    
    
    @IBOutlet weak var mypo: UILabel!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        babtn.layer.cornerRadius = babtn.frame.width/2
        babtn.layer.borderWidth = 6
        babtn.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        
        babtn.clipsToBounds = true
        Global.shared.audioHomePage.pause()
   //StoretableView.reloadData()
        
        StoretableView.delegate = self
        StoretableView.dataSource = self
        
        //
        //        PinnedRocket.layer.borderWidth = 2
        //        PinnedRocket.layer.borderColor = #colorLiteral(red: 0.8993717432, green: 0.3597564697, blue: 0.2627948225, alpha: 1)
        //        PinnedRocket.layer.cornerRadius = 10
        //
        
      
        
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
                let myROCK2 = snapshot!.documents.first!.get("currentRockIMG") as! String
                //  guard let name1  = doc.get("name") as? String else { continue }
                // self.myrockets = snapshot!.documents.first!.get("rockets") as! [String]
                //   self.semster  = snapshot!.documents.first!.get("Semster") as! String
                self.points = points1
                self.myrockets.append(contentsOf: myrockets1)
                self.current = myROCK
                self.currentimg = myROCK2
               // print("names",self.names)
                
                print("names.count",self.names.count)
                
                print("myrockets",self.myrockets)
                print("my points",self.points)
                
                
                self.mypo.text = self.a
                self.pinnedIMG.image = UIImage(named: myROCK2 )
                self.pinnedTXT.text = myROCK
                
                
                //  print("semster:", self.semster)
                
               // self.StoretableView.reloadData()
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
                    
                    //                    var a = ""
                    //                    let formatter: NumberFormatter = NumberFormatter()
                    //                    var  x1: Int!
                    //                    x1 = doc.get("price") as? Int
                    //                    var  a1 = NSNumber(value: x1)
                    //                  formatter.locale = Locale(identifier: "ar")
                    //                   a = formatter.string(from: a1)!
                    //amani end
                    
                    print("name1",name1)
                    print("price1",price1)
                    //  print("ARABIC",a)
                    
                    //   self.arr.append(price1,name1,photo1)
                    
                    
                    //   self.prices.append(Int(a) ?? 0)
                   // self.prices.append(price1)
                    //self.names.append(name1)
                   // self.photo.append(photo1)
                  //  Global.shared.allShop = price1+":"+name1+":"+photo1
                    var dd = String(price1)
                    dd += ":"+name1+":"+photo1
                    self.allShop.append(dd)
                    
                    
                }
                
                
                
                
                
                
            }
            print("Global.shared.allShop",allShop)
            AllArray()
            
            self.StoretableView.reloadData()
            //
            
            
            // tableSorted2 = tableSorted ?? [(0,"","")]
            //  let sortedArray1 = prices.sort { ($0 as Int) < ($1 as Int) }
            //  print("44######")
            // print(sortedArray1)
            
            
            
           }
        self.StoretableView.reloadData()

       
        //  let a_snapshot = try await db.collection("Child").wherefgetDocuments()
        //self.StoretableView.reloadData()
        
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
        
        mycell.rocketPrice.text? = String (prices[indexPath.row])
        
        
        
        // mycell.rocketImage.image =
        if myrockets.contains(names[indexPath.row]) {
            if (current == names[indexPath.row] ){
                
                
                //   mycell.currentBTN.isUserInteractionEnabled = false
                //  mycell.currentBTN.isHidden=false
                mycell.rocketBtn.isHidden=true
                mycell.updatebtn.isHidden=true
                mycell.lockIMG.isHidden = true
                mycell.rocketImage.alpha = 1
                pinnedIMG.image = UIImage(named: photo[indexPath.row])
                pinnedTXT.text = names[indexPath.row]
                
                
            }
            else{
                print("you have it ")
                mycell.rocketBtn.isHidden=true
                //  mycell.currentBTN.isHidden=true
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
         
            mycell.rocketBtn.isHidden=false
            
           
            mycell.rocketImage.alpha = 1
           
            mycell.lockIMG.isHidden = true
           
            mycell.rocketBtn.isUserInteractionEnabled = true
            
        }
        else {//can not buy
            mycell.updatebtn.isHidden=true
            mycell.rocketBtn.isHidden=false
            
            mycell.rocketImage.alpha = 0.5
            mycell.lockIMG.isHidden = false
            //   mycell.rocketBtn.layer.cornerRadius = 20
            mycell.rocketBtn.isUserInteractionEnabled = false
        }
        let storageRef = Storage.storage().reference()
        let photoRef = storageRef.child(photo[indexPath.row])
        
        
      
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
    func AllArray(){
        var alliteration = 0
        
        while alliteration < allShop.count  { //big loop #array length first ind
            var ch = Character(":") //righ: 2 :30 up: 3 :11
            var result = allShop[alliteration].split(separator: ch)
            
            var price1 = Int(result[0])! //price
            var name1 = String(result[1])//name
            var photo1 = String(result[2]) //photo
            
            print("resultx ",price1)
            print("resulty ",name1)
            print("resullabel",photo1)
            
            var indexin = alliteration + 1
            while indexin < allShop.count  {//sec ind2
                print("indexin",indexin)
                var result2 = allShop[indexin].split(separator: ch)
                
                var price2next = Int(result2[0])! //price2
                var namenext = String(result2[1])//name2
                var photonext = String(result2[2]) //phoh2
                print("resultxnext",price2next)
                print("resultynext ",namenext)
                print("resullabelnext",photonext)
                
                
                var temp = ""
                var indexinpostion = alliteration + 1
                
                
                
                
                
                if(price1 > price2next){
                    print("eneter   ???",price1,">",price2next)
                    temp = allShop[alliteration]
                   allShop[alliteration] = allShop[indexin]
                 allShop[indexin] =  temp
                }
                
                
                
                
                indexin += 1
            }
            
            
            print("alliteration",   alliteration)
            alliteration += 1
        }
        print(" FINAL allLablels after sort  ", allShop)
        var h = 0
        var xx = allShop.count
        while h < xx {
            let r2 = allShop[h].split(separator: ":")
            print(r2)
            names.append(String(r2[1]))
            prices.append(Int(r2[0])!)
           photo.append(String(r2[2]))
            print("           r2[0])[h] ",r2[0])
//            Int(result2[0])! //price2
//            var namenext = String(result2[1])//name2
//            var photonext = String(result2[2]) //ph
            h += 1
        }
       
    
    }
    
}
    
