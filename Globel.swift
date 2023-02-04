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
    
    var enabled = false
    var  stopis = false
      
    var allLablels = [String]()
    var winAlertFirstGame = ["left","left","up","up"]
    var winAlertSecondGame = ["left","left","down","down","right"]
    var WinAlertThirdGame = ["loop2","up","up","right","loop"]
    public   var endgame = false
    var rocketImage = ""
    var EmptyStopArray = true
//    var GoBackHomeStopCamera = true
    var audioHomePage : AVPlayer!
    var audiomsgP1 : AVPlayer!
    var audiomsgP2 : AVPlayer!
    var audiomsgP3 : AVPlayer!
    var audioi1VC : AVPlayer!
    var audioi2VC : AVPlayer!
    var audioi3VC : AVPlayer!
    var audioi4VC : AVPlayer!
    var audioi5VC : AVPlayer!
//    var longerTime =  true

}
