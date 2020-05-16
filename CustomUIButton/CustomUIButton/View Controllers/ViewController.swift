//
//  ViewController.swift
//  CustomUIButton
//
//  Created by Alex Rhodes on 5/16/20.
//  Copyright © 2020 Alex Rhodes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        let customButton = ARCustomButton(title: "START", width: view.bounds.width/3)
        
        view.addSubview(customButton)
        
        customButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        customButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }


}

