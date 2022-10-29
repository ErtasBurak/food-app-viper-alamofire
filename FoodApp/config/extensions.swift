//
//  extensions.swift
//  FoodApp
//
//  Created by Burak Ertaş on 27.10.2022.
//

import UIKit
import Lottie

extension UITableView {

    func setEmptyMessage(_ message: String) {
        
        let uiView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
  
        var animationView = LottieAnimationView()
        animationView = .init(name: "emptyCart")
        animationView.frame = CGRect(x: uiView.bounds.size.width * 0.2, y: uiView.bounds.size.height * 0.1, width: uiView.bounds.size.width * 0.6, height: uiView.bounds.size.height * 0.5)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        let messageLabel = UILabel(frame: CGRect(x: uiView.bounds.size.width * 0.2, y: uiView.bounds.size.height * 0.5, width: uiView.bounds.size.width * 0.7, height: uiView.bounds.size.height * 0.9))
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        
        uiView.addSubview(animationView)
        uiView.addSubview(messageLabel)

        self.backgroundView = uiView
        
    }

    func restore() {
        self.backgroundView = nil
        
    }
}

extension UIImageView{
    func imageConfig() -> UIImageView {
        
        let maskLayer = CAShapeLayer(layer: self.layer)
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x:0, y:0))
        bezierPath.addLine(to: CGPoint(x:self.bounds.size.width, y:0))
        bezierPath.addLine(to: CGPoint(x:self.bounds.size.width, y:self.bounds.size.height))
        bezierPath.addQuadCurve(to: CGPoint(x:0, y:self.bounds.size.height), controlPoint: CGPoint(x:self.bounds.size.width/2, y:self.bounds.size.height-self.bounds.size.height*0.2))
        bezierPath.addLine(to: CGPoint(x:0, y:0))
        bezierPath.close()
        maskLayer.path = bezierPath.cgPath
        maskLayer.frame = self.bounds
        maskLayer.masksToBounds = true
        self.layer.mask = maskLayer
        return self
        
    }
}
