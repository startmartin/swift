//
//  HappyniessViewController.swift
//  Happyniess
//
//  Created by martin on 2018/4/18.
//  Copyright © 2018 martin. All rights reserved.
//

import UIKit

class HappyniessViewController: UIViewController, FaceViewDataSource {
    
    @IBOutlet var faceView: FaceView!{
        didSet{
            faceView.dataSource = self
            let handler = #selector(FaceView.pinchScale(pinchRecognizer:))
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target:faceView, action:handler))
        }
    }
    private struct Constants {
        static let HappyniessGestureScale:CGFloat = 4.0
    }
    @IBAction func changeHappyniess(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed,.ended:
            let translation = gesture.translation(in: faceView)
            happiness -= Int(translation.y/Constants.HappyniessGestureScale);
        default:
            break
        }
    }
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50
    }
    
    var happiness: Int = 90{ //0 very sad , 100=ecstatic
        didSet{
            happiness = min(max(happiness,0),100)
            print("happiness = \(happiness)")
            updateUI()
        }
    }
 
    @objc  func updateUI(){
        faceView.setNeedsDisplay()
    }
}
