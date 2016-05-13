//
//  battleselect.swift
//  TechMon
//
//  Created by 今村惟人 on 2016/02/18.
//  Copyright © 2016年 今村惟人. All rights reserved.
//

import UIKit
import AVFoundation

class BattleSelectViewController: UIViewController ,AVAudioPlayerDelegate {
    var mahouseki: Int = 0
    var stamina: Float = 0
    override func viewWillAppear(animated: Bool) {
        stamina = NSUserDefaults.standardUserDefaults().floatForKey("stamina")
        
        
    }
    @IBAction func dragon1(){
        stamina = stamina - 10
        NSUserDefaults.standardUserDefaults().setFloat(stamina, forKey: "stamina")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    @IBAction func dragon2(){
        stamina = stamina - 30
        NSUserDefaults.standardUserDefaults().setFloat(stamina, forKey: "stamina")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    @IBAction func backtolobby(){
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    //    @IBAction func backtotop (){
    //        performSegueWithIdentifier("lobbyviewcontroller",sender: nil)
    //    }
}