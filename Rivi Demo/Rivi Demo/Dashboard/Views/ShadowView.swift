//
//  ShadowView.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 29/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    private var shadowLayer: CAShapeLayer?
    private var cornerRadius: CGFloat = 10.0
    private var fillColor: UIColor = .white // the color applied to the shadowLayer, rather than the view's backgroundColor

    override func layoutSubviews() {
        super.layoutSubviews()
        if self.shadowLayer == nil {
            self.shadowLayer = CAShapeLayer()
            self.shadowLayer?.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius).cgPath
            self.shadowLayer?.fillColor = self.fillColor.cgColor
            self.shadowLayer?.shadowColor = UIColor(red: 169.0/255.0, green: 172.0/255.0, blue: 189.0/255.0, alpha: 0.25).cgColor
            self.shadowLayer?.shadowPath = self.shadowLayer?.path
            self.shadowLayer?.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.shadowLayer?.shadowOpacity = 1
            self.shadowLayer?.shadowRadius = 16
            self.layer.insertSublayer(self.shadowLayer!, at: 0)
        }
    }

    func updateShadow() {
        self.shadowLayer?.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius).cgPath
        self.shadowLayer?.shadowPath = self.shadowLayer?.path
    }
}

extension UIView {
    
    private var cornerRadius: CGFloat {
        return 10.0
    }
    
    private var fillColor: UIColor {
        return .white
    }
    
    func addShadow() {
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius).cgPath
        shadowLayer.fillColor = self.fillColor.cgColor
        shadowLayer.shadowColor = UIColor(red: 169.0/255.0, green: 172.0/255.0, blue: 189.0/255.0, alpha: 0.25).cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 16
        self.layer.insertSublayer(shadowLayer, at: 0)
    }
}
