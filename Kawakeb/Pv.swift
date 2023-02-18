//
//  Pv.swift
//  Kawakeb
//
//  Created by Modhy Abduallh on 28/05/1444 AH.
//

import UIKit

class Pv: UIViewController {

    @IBOutlet weak var equation: UILabel!
    @IBOutlet weak var answer: UITextField!
    @IBOutlet weak var submitB: UIButton!
    
    @IBOutlet weak var msg: UILabel!
    
    
    let formatter: NumberFormatter = NumberFormatter()
    
    
    var actual: Int!
    var ans: Int?
    var  x1: Int!
    var  x2: Int!
    var  x: Character!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        msg.isHidden = true
         actual = eq()
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action:nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.resignFirstResponder()
        return(true)
    }
    //touch out
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //return key
    
    func eq() -> Int{
        x1 = Int(exactly: arc4random_uniform(10) + 1)!
        x2 =  Int(exactly: arc4random_uniform(10) + 1)!
        var  a1 = NSNumber(value: x1)
        var  a2 = NSNumber(value: x2)
     //   var a1 = NSNumber(value: x1)
                formatter.locale = Locale(identifier: "ar")
               let a = formatter.string(from: a1)!
               let b = formatter.string(from: a2)!

        
        let op = Int.random(in: 0..<2)
        switch op {
            case 0:
            equation.text = "\(a) + \(b)"
            return x1 + x2
//            case 1:
//            equation.text = "\(a) - \(b)"
//            return x1 - x2
//            case 2:
//            equation.text = "\(x1!) / \(x2!)"
//            return x1 / x2
            case 1:
            equation.text = "\(a) x \(b)"
            return x1 * x2
        default:
            equation.text =  "  "
            return 0
        }
   
    }

    @IBAction func pressed(_ sender: Any) {
//        formatter.locale = NSLocale(localeIdentifier: "EN") as Locale?
//        let final = formatter.number(from: answer.text!)
//        var check = Int(final)
//            print("\(check)")
        let check = answer.text
        
        let bl = (check?.isEmpty)!

        if(bl){
            msg.isHidden = false
            msg.text = "الرجاء ادخال رقم صحيح"
        }
        else{
        let b2 = check?.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil
            if b2{
                formatter.locale = NSLocale(localeIdentifier: "EN") as Locale?
                let final = formatter.number(from: check!)!
                       var ans = Int(final)
                           print("\(ans)")
       // ans = Int(answer.text!)!
        if (actual==ans)
        {
            self.performSegue(withIdentifier: "editProfileSegue", sender: self)
        }
        else
        {
//            let alert = UIAlertController(title: "تنبيه", message: "اجابة خاطئة،  حاول مجددًا!", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "حسنًا", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
            msg.isHidden = false
            msg.text = "اجابة خاطئة،  حاول مجددًا!"

        }}
            else{
                msg.isHidden = false
                msg.text = "الرجاء ادخال رقم صحيح"
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
