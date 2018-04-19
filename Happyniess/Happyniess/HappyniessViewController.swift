//
//  HappyniessViewController.swift
//  Happyniess
//
//  Created by martin on 2018/4/18.
//  Copyright © 2018 martin. All rights reserved.
//

import UIKit

class HappyniessViewController: UIViewController, FaceViewDataSource {
    
    @IBOutlet var faceView: FaceView!{
        didSet{
            faceView.dataSource = self
        }
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(90-50)/50
    }
    
    var happiness: Int = 90{ //0 very sad , 100=ecstatic
        didSet{
            happiness = min(max(happiness,0),100)
            print("happiness = \(happiness)")
            updateUI()
        }
    }
 
    func updateUI(){
        faceView.setNeedsDisplay()
    }
}
