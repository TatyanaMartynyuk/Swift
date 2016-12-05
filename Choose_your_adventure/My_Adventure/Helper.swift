//
//  Helper.swift
//  My_Adventure
//
//  Created by Tatyana Martynyuk on 10/11/16.
//  Copyright © 2016 Tatyana Martynyuk. All rights reserved.
//

import UIKit

class Helper: UIViewController {

    override func viewDidLoad() {
        let startOverButton = UIBarButtonItem(title: "Start Over", style: .plain, target: self, action:  #selector(Helper.startOver))
        self.navigationItem.rightBarButtonItem = startOverButton
        
        // left button is hidden
        let hiddenLeftBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = hiddenLeftBarButton
    }
    
    func startOver() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}
