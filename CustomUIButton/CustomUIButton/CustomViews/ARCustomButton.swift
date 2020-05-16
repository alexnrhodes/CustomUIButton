//
//  ARCustomButton.swift
//  CustomUIButton
//
//  Created by Alex Rhodes on 5/16/20.
//  Copyright © 2020 Alex Rhodes. All rights reserved.
//

import UIKit

class ARCustomButton: UIButton {
    
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
        layer.shadowOffset = CGSize(width: 0, height: heightConstant * 0.05)
        layer.shadowColor = UIColor.black.cgColor
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.init(name: "Futura-CondensedExtraBold", size: 30) // UIFont.systemFont(ofSize: 20, weight: .bold)
        print(UIFont.fontNames(forFamilyName: "Futura"))
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.layer.shadowRadius = 5
        titleLabel?.layer.shadowOpacity = 0.5
        titleLabel?.layer.masksToBounds = false
        titleLabel?.layer.shadowOffset = CGSize(width: titleLabel?.bounds.width ?? 0 * 0.1, height: 0)//titleLabel?.bounds.height ?? 0 * 0.1)
        titleLabel?.layer.shadowColor = UIColor.black.cgColor
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
            context.setFillColor(#colorLiteral(red: 0, green: 0.7254568934, blue: 0, alpha: 1))
            context.fillPath()
            
            let innerButtonEllipse = CGRect(x: rect.size.width * 0.025, y: rect.size.height * 0.025, width: rect.size.width * 0.95, height: rect.size.height * 0.95)
            
            context.addEllipse(in: innerButtonEllipse)
            context.clip()
            
            let innerColorSpaceEllipse = CGColorSpaceCreateDeviceRGB()
            
            // 2
            let innerColorLocationsEllipse: [CGFloat] = [0.0, 1.0]
            
            // 3
            let innerColorsEllipse = [startColorEllipse.cgColor, endColorEllipse.cgColor]
            print(startColorEllipse)
            // 4
            let innerGradientEllipse = CGGradient(colorsSpace: innerColorSpaceEllipse,
                                             colors: innerColorsEllipse as CFArray,
                                             locations: innerColorLocationsEllipse)!
            
            let innerStartPointEllipse = CGPoint(x: rect.size.width, y: rect.size.height)
            let innerEndPointEllipse = CGPoint(x: 0, y: buttonEllipse.height)
            context.drawLinearGradient(innerGradientEllipse,
                                       start: innerStartPointEllipse,
                                       end: innerEndPointEllipse,
                                       options: [])
            context.setFillColor(#colorLiteral(red: 0, green: 0.3891800344, blue: 0.0907118395, alpha: 1))
            context.fillPath()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
}
