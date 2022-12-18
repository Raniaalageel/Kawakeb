//
//  UserObject.swift
//  Kawakeb
//
//  Created by Modhy Abduallh on 23/05/1444 AH.
//
import Foundation
import Firebase

class UserObject {
    
    var ID : String?
    var Stamp : TimeInterval?
    var Name : String?
    var Age : Int?
    var IsMale : Bool?
    
    init(ID : String , Stamp : TimeInterval, Name : String, Age : Int, IsMale : Bool) {
        self.ID = ID
        self.Stamp = Stamp
        self.Name = Name
        self.Age = Age
        self.IsMale = IsMale
    }
    
    init(Dictionary : [String : AnyObject]) {
        self.ID = Dictionary["ID"] as? String
        self.Stamp = Dictionary["Stamp"] as? TimeInterval
        self.Name = Dictionary["Name"] as? String
        self.Age = Dictionary["Age"] as? Int
        self.IsMale = Dictionary["IsMale"] as? Bool
    }
    
    func MakeDictionary()->[String : AnyObject] {
        var New : [String : AnyObject] = [:]
        New["ID"] = self.ID as AnyObject
        New["Stamp"] = self.Stamp as AnyObject
        New["Name"] = self.Name as AnyObject
        New["Age"] = self.Age as AnyObject
        New["IsMale"] = self.IsMale as AnyObject
        return New
    }
    
    func Upload(){
        guard let id = self.ID else { return }
        Firestore.firestore().collection("Users").document(id).setData(MakeDictionary())
    }
    
//    func Remove(){
//        guard let id = self.ID else { return }
//        Firestore.firestore().collection("Users").document(id).delete()
//    }
    
    
    
    
}


class UserApi {
    
    
    static func GetUser(ID : String, completion : @escaping (_ User : UserObject)->()){
        
        Firestore.firestore().collection("Users").document(ID).addSnapshotListener { (Snapshot : DocumentSnapshot?, Error : Error?) in
            
            if let data = Snapshot?.data() as [String : AnyObject]? {
               let New = UserObject(Dictionary: data)
                completion(New)
            }
            
        }
        
    }
}


