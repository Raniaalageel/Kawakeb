//
//  Globel.swift
//  Kawakeb
//
//  Created by Rania Alageel on 24/05/1444 AH.
//

import Foundation
import AVFoundation

class Global{
    public static let shared = Global()
    
    public var useremailshare : String = ""
    public var userpasswordshare = ""
    public var userbirthday = ""
    public var usercharacter = ""
    public var usercharacterName = ""
    var session = AVCaptureSession()
    var enabled = false
    var  stopis = false
      
    var allLablels = [String]()
    public   var endgame = false
var rocketImage = ""
    
    
}
