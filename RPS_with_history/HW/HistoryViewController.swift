//
//  HistoryViewController.swift
//  HW
//
//  Created by Tatyana Martynyuk on 10/26/16.
//  Copyright © 2016 Tatyana Martynyuk. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    var history = [RPSMatch]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableCell", for: indexPath)
        let colorCell = cell as!MyTableCell
        
        // Do not forget to set Identifier for the cell!
        // And dataSource for TableView
        let matchForThisRow = history[indexPath.row]
        let finalResult = matchForThisRow.player1.stringValue + " vs. " + matchForThisRow.player2.stringValue
        colorCell.firstLbl.text = finalResult
        
        
        return colorCell
        
        
    }
    
    
}
