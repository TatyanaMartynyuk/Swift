//
//  ResultViewController.swift
//  HW
//
//  Created by Tatyana Martynyuk on 10/23/16.
//  Copyright © 2016 Tatyana Martynyuk. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    var userMove: RPS!
    var compMove: RPS!
    var resultString: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        
        let result = userMove.compareTo(other: compMove)
        
        if (result == 0) {
            resultString = "\(userMove!) vs \(compMove!). Tie!"
            label.text = resultString
        }
        else if (result == 1) {
            resultString = "\(userMove!) vs \(compMove!). You won!"
            label.text = resultString
        }
        else {
            resultString = "\(userMove!) vs \(compMove!). You lost!"
            label.text = resultString
        }
        super.viewWillAppear(animated)
    }
}
