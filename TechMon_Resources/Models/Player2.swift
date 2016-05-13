//
//  Player2.swift
//  TechMon
//
//  Created by 今村惟人 on 2016/03/10.
//  Copyright © 2016年 今村惟人. All rights reserved.
//

import UIKit

class Player2 {
    
    var name: String! = "勇者"
    var maxHP: Float! = 200
    var currentHP: Float! = 200
    var attackPoint: Float! = 60
    var speed: Float! = 1.2
    var currentTP: Float! = 100//技を繰り出すためのゲージの値
    var maxTP: Float! = 100
    var currentMovePoint: Float! = 0 //行動するためのゲージの値
    var maxMovePoint: Float! = 10
    var image: UIImage! = UIImage(named: "yusya.png")
    
    init(name:String,imageName: String) {
        
        self.name = name
        self.image = UIImage(named: imageName)
        
    }
    
}
