//
//  ViewController.swift
//  Kawakeb
//
//  Created by Rania Alageel on 20/05/1444 AH.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        print("Hello sara alsaleh")
        self.tabBarController?.tabBar.isHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action:nil)

    }

}

