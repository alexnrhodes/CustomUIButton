//
//  ARCustomButton.swift
//  CustomUIButton
//
//  Created by Alex Rhodes on 5/16/20.
//  Copyright © 2020 Alex Rhodes. All rights reserved.
//

import UIKit

class ARCustoomButton: UIButton {
    
    fileprivate var wAnchor: NSLayoutConstraint?
    fileprivate var hAnchor: NSLayoutConstraint?
       
    fileprivate var widthConstant: CGFloat?
    fileprivate var heightConstant: CGFloat?
    
    @IBInspectable var startColorEllipse: UIColor = UIColor.green
    @IBInspectable var endColorEllipse: UIColor = UIColor.systemGreen
    
    
    init(title: String, width: CGFloat) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        wAnchor =  widthAnchor.constraint(equalToConstant: width)
        guard let wAnchor = wAnchor else {return}
        wAnchor.isActive = true
        widthConstant = wAnchor.constant
        
        hAnchor = heightAnchor.constraint(equalToConstant: width)
        guard let hAnchor = hAnchor else {return}
        hAnchor.isActive = true
        heightConstant = hAnchor.constant
        
//        phaseTwo(title: title)
    }
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            let buttonEllipse = CGRect(x: rect.size.width * 0.375, y: rect.size.height * 0.25, width: rect.size.width * 0.25, height: rect.size.height * 0.73)
            
            context.addEllipse(in: buttonEllipse)
            context.clip()
            
            let colorSpaceEllipse = CGColorSpaceCreateDeviceRGB()
            
            // 2
            let colorLocationsEllipse: [CGFloat] = [0.0, 1.0]
            
            // 3
            let colorsEllipse = [startColorEllipse.cgColor, endColorEllipse.cgColor]
            
            // 4
            let gradientEllipse = CGGradient(colorsSpace: colorSpaceEllipse,
                                             colors: colorsEllipse as CFArray,
                                             locations: colorLocationsEllipse)!
            
            let startPointEllipse = CGPoint(x: 0, y: 0)
            let endPointEllipse = CGPoint(x: 0, y: buttonEllipse.height)
            context.drawLinearGradient(gradientEllipse,
                                       start: startPointEllipse,
                                       end: endPointEllipse,
                                       options: [])
            context.setFillColor(#colorLiteral(red: 0, green: 0.3891800344, blue: 0.0907118395, alpha: 1))
            context.fillPath()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
}
