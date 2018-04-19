//
//  FaceView.swift
//  Happyniess
//
//  Created by martin on 2018/4/18.
//  Copyright © 2018 martin. All rights reserved.
//

import UIKit

class FaceView: UIView {
    var lineWidth:CGFloat = 3{
        didSet{
            setNeedsDisplay()
        }
    }
    var lineColor:UIColor = UIColor.blue{
        didSet{
            setNeedsDisplay()
        }
    }
    var scale:CGFloat = 0.90 {
        didSet{
            setNeedsDisplay()
        }
    }
    var faceCenter:CGPoint{
        return convert(center, from:superview)
    }
    var faceRadius:CGFloat{
        return min(bounds.size.width,bounds.size.height)/2*scale
    }
    //for eye and mouth const
    private struct Scaling{
        static let FaceRadiusToEyeRadiusRatio:CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio:CGFloat = 3
        static let FaceRadiusToEyeSeparationRatio:CGFloat = 1.5
        static let FaceRadiusToMouthWidthRatio:CGFloat = 1
        static let FaceRadiusToMouthHeightRatio:CGFloat = 1
        static let FaceRadiusToMouthOffsetRatio:CGFloat = 3
    }
    private enum Eye{case Left, Right}
    private func bezierPathForEye(whichEye:Eye) -> UIBezierPath{
        let eyeRadius = faceRadius/Scaling.FaceRadiusToEyeRadiusRatio
        let eyeVerticalOffset = faceRadius/Scaling.FaceRadiusToEyeOffsetRatio
        let eyeHorizonSeparation = faceRadius/Scaling.FaceRadiusToEyeSeparationRatio
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeVerticalOffset
        switch whichEye{
        case .Left:eyeCenter.x -= eyeHorizonSeparation/2
        case .Right:eyeCenter.x += eyeHorizonSeparation/2
        }
        let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        path.lineWidth = lineWidth
        return path
    }
    //mouth
    private func bezierPathForSmile(flactionOfMaxSmile:Double)-> UIBezierPath{
        let mouthWidth = faceRadius/Scaling.FaceRadiusToMouthWidthRatio
        let mouthHeight = faceRadius/Scaling.FaceRadiusToMouthHeightRatio
        let mouthVerticalOffset = faceRadius/Scaling.FaceRadiusToMouthOffsetRatio
        
        let smileMouthHeight = CGFloat(min(max(flactionOfMaxSmile,-1),1)) * mouthHeight
        let start = CGPoint(x:faceCenter.x-mouthWidth/2, y:faceCenter.y + mouthVerticalOffset)
        let end = CGPoint(x:faceCenter.x+mouthWidth/2, y:start.y)
        let cp1 = CGPoint(x:start.x + mouthWidth/3, y:start.y + smileMouthHeight/3)
        let cp2 = CGPoint(x:end.x - mouthWidth/3, y:end.y + smileMouthHeight/3)
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
    }
    override func draw(_ rect: CGRect) {
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        facePath.lineWidth = lineWidth
        lineColor.set()
        facePath.stroke()
        bezierPathForEye(whichEye: .Left).stroke()
        bezierPathForEye(whichEye: .Right).stroke()
        let smiliness = 1.0
        bezierPathForSmile(flactionOfMaxSmile: smiliness).stroke()
    }
    

}
