//
//  Enemy2.swift
//  TechMon
//
//  Created by 今村惟人 on 2016/03/10.
//  Copyright © 2016年 今村惟人. All rights reserved.
//


import UIKit

class Enemy2 {
    
    var name: String! = "ドラゴン2"
    var maxHP: Float! = 800
    var currentHP: Float! = 800
    var attackPoint: Float! = 40
    var speed: Float! = 1.2
    var currentMovePoint: Float! = 0//行動するためのゲージの値
    var maxMovePoint: Float! = 35
    
    var image: UIImage! = UIImage(named: "monster.png")
    
    init(name:String,imageName:String) {
        
        self.name = name
        self.image = UIImage(named: imageName)
    }
}


