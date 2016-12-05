//
//  ViewController.swift
//  My_Adventure
//
//  Created by Tatyana Martynyuk on 10/9/16.
//  Copyright © 2016 Tatyana Martynyuk. All rights reserved.
//

import UIKit

class HomePage: UIViewController {
    @IBOutlet var textView : UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont.boldSystemFont(ofSize: 10)
        textView.textColor = UIColor.white
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil {
            _ = segue.destination as! Option
        }
    }
}

class Option: Helper {
    @IBOutlet var textView : UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont.boldSystemFont(ofSize: 13)
        textView.textColor = UIColor.gray
    }
}
