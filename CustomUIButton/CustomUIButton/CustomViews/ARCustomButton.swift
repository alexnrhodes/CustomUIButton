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
        
        phaseTwo(title: title)
    }
    
    fileprivate func phaseTwo(title: String) {
         guard let widthConstant = widthConstant, let heightConstant = heightConstant else { return }
        layer.cornerRadius = 12
        backgroundColor = .clear
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: widthConstant * 0.1, height: heightConstant * 0.1)
        layer.shadowColor = UIColor.black.cgColor
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        addTarget(self, action: #selector(down), for: .touchDown)
        addTarget(self, action: #selector(up), for: .touchUpInside)
        
    }
    
    @objc fileprivate func down() {
            
            wAnchor?.isActive = false
            hAnchor?.isActive = false
            
            guard let widthConstant = widthConstant, let heightConstant = heightConstant else { return }
            wAnchor?.constant = widthConstant - widthConstant/15
            hAnchor?.constant  = heightConstant - heightConstant/15
            
            wAnchor?.isActive = true
            hAnchor?.isActive = true
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
            })
        }
        
        @objc fileprivate func up() {
            
            wAnchor?.isActive = false
            hAnchor?.isActive = false
            
            guard let widthConstant = widthConstant, let heightConstant = heightConstant else { return }

            wAnchor?.constant = widthConstant
            hAnchor?.constant  = heightConstant
            
            wAnchor?.isActive = true
            hAnchor?.isActive = true
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.superview?.layoutIfNeeded()
                self.transform = .identity
            })
        }
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            let buttonEllipse = CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height)
            
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
