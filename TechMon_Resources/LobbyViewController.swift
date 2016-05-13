//
//  LobbyViewController.swift
//  TechMon
//
//  Created by 今村惟人 on 2016/01/21.
//  Copyright © 2016年 今村惟人. All rights reserved.
//

import UIKit
import AVFoundation

class LobbyViewController: UIViewController ,AVAudioPlayerDelegate {
    
    var stamina: Float = 0
    var staminaTimer: NSTimer!
    var mahouseki: Int = 0
    var util: TechDraUtility!
    var player: Player?
    
    var yusya: Int = 0
    
    var keikenti: Float = 0
    var keikentibar: Float = 0
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var staminaBar: UIProgressView!
    @IBOutlet var levelLabel: UILabel!
    @IBOutlet var mahousekilabel: UILabel!
    @IBOutlet var yusyaimage: UIImageView!
    @IBOutlet var keikentiBar: UIProgressView!
    
    
    override func viewDidLoad() {
        //        NSLog("魔法石の数は...%dです", mahouseki)
        super.viewDidLoad()
        keikentiBar.transform = CGAffineTransformMakeScale(1.0, 4.0)
        staminaBar.transform = CGAffineTransformMakeScale(1.0, 4.0)
        NSLog("魔法石の数は...%dです", mahouseki)
        stamina = 100
        util = TechDraUtility()
        
        cureStamina()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(true)
        util.playBGM("lobby")
        
        stamina = NSUserDefaults.standardUserDefaults().floatForKey("stamina")
        mahouseki = NSUserDefaults.standardUserDefaults().integerForKey("mahouseki")
        mahousekilabel.text = String(mahouseki)
        NSLog("魔法石の数は%dです", mahouseki)
        
        keikenti = NSUserDefaults.standardUserDefaults().floatForKey("keikenti")
       
        NSLog("経験値は%fでした",keikenti)
        
        if keikenti >= 200 {
            player = Player(name: "勇者3", imageName: "m36.png")
        }
        
        if keikenti > 100 {
            player = Player(name: "勇者2", imageName: "m52.png")
            NSLog("勇者２でした")
        }
        else{
            player = Player(name: "勇者1", imageName: "m19.png")
             //NSLog("経験値は...%dでした",keikenti)
        }
        
        yusyaimage.image = player!.image
        nameLabel.text = player!.name
        
        NSLog("経験値は%fでした(再)",keikenti)

        
        if keikenti >= 300 {
            keikentibar = keikenti - 300
            keikentiBar.progress = keikentibar / 800
        }
        if keikenti > 100 {
            keikentibar = keikenti - 100
            keikentiBar.progress = keikentibar / 300
        }
        else {
            keikentibar = keikenti
            keikentiBar.progress = keikentibar / 100
        }
        keikentiBar.progress = keikentibar / 100
    }
    
    override func viewWillDisappear(animated: Bool) {
        util.stopBGM()
    }
    
    @IBAction func toBattle() {
        NSUserDefaults.standardUserDefaults().setFloat(stamina, forKey: "stamina")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    @IBAction func toGacha() {
        self.performSegueWithIdentifier("gachaviewcontroller", sender: nil)
    }
    
    func cureStamina(){
        staminaTimer = NSTimer.scheduledTimerWithTimeInterval(3.0, target:  self, selector:
            "updateStaminaValue", userInfo: nil, repeats: true)
        staminaTimer.fire()
    }
    
    func updateStaminaValue(){
        if stamina <=   100 {
            stamina = stamina + 1
            staminaBar.progress = stamina / 100
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toBattle" {
            let battleselectviewcontroller = segue.destinationViewController as!BattleSelectViewController
            
            battleselectviewcontroller.mahouseki = self.mahouseki
        }
        NSLog("魔法石の数は...%dです", mahouseki)
    }
    
    @IBAction func stamina(sender: UIButton) {
        let alertController = UIAlertController(title: "スタミナ回復", message: "魔法石を1消費してスタミナを全回復します。", preferredStyle: .Alert)
        let otherAction = UIAlertAction(title: "OK", style: .Default) {
            action in self.stamina = 100
            self.mahouseki = NSUserDefaults.standardUserDefaults().integerForKey("mahouseki")
            self.mahouseki = self.mahouseki - 1
            self.mahousekilabel.text = String(self.mahouseki)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .Cancel) {
            action in
        }
        alertController.addAction(otherAction)
        alertController.addAction(cancelAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func gacha() {
        performSegueWithIdentifier("gachaviewcontroller",sender: nil)
    }
    
    @IBAction func reset(sender: UIButton) {
        let alertController = UIAlertController(title:"初期化", message: "スタミナと魔法石とキャラ、経験値をリセットします。",preferredStyle: .Alert)
        let otherAction = UIAlertAction(title:"OK", style:  .Default) {
            action in self.stamina = 100
            self.mahouseki = NSUserDefaults.standardUserDefaults().integerForKey("mahouseki")
            self.mahouseki = 0
            self.mahousekilabel.text = String(self.mahouseki)
            NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "mahouseki")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            self.keikenti = NSUserDefaults.standardUserDefaults().floatForKey("keikenti")
            self.keikenti = 0
            NSUserDefaults.standardUserDefaults().setFloat(self.keikenti, forKey: "keikenti")
            NSUserDefaults.standardUserDefaults().synchronize()
            self.player = Player(name: "勇者1", imageName: "m19.png")
            self.nameLabel.text = self.player!.name
            self.yusyaimage.image = self.player!.image
            if self.keikenti >= 300{
                self.keikentibar = self.keikenti - 300
                self.keikentiBar.progress = self.keikentibar / 800
            } else if self.keikenti >= 100{
                self.keikentibar = self.keikenti - 100
                self.keikentiBar.progress = self.keikentibar / 300
            }else {
                self.keikentibar = self.keikenti
                self.keikentiBar.progress = self.keikentibar / 100
            }
            NSLog("魔法石の数は...%dです(初期化後)", self.mahouseki)
            NSLog("経験値は...%fです(初期化後)", self.keikenti)
        }
        let cancelAction = UIAlertAction(title:"キャンセル", style:  .Cancel) {
            action in
        }
        alertController.addAction(otherAction)
        alertController.addAction(cancelAction)
        presentViewController(alertController,animated: true, completion: nil)
    }
}
