//
//  ViewController.swift
//  HW
//
//  Created by Tatyana Martynyuk on 10/23/16.
//  Copyright © 2016 Tatyana Martynyuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableData: [RPS] = []
    var compRPS = RPS.Paper
    var userRPS = RPS.Rock
    
    // Here is the array to store history
    var history = [RPSMatch]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableData = [
            RPS.Rock,
            RPS.Paper,
            RPS.Scissors
        ]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableCell", for: indexPath)
        let rpsCell = cell as! MyTableCell
        rpsCell.firstLbl!.text = tableData[indexPath.row].stringValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            userRPS = .Rock
        }
        else if (indexPath.row == 1) {
            userRPS = .Paper
        }
        else if (indexPath.row == 2){
            userRPS = .Scissors
        }
        
        
        // Generating random RPS for compRPS
        compRPS = RPS.random()
        
        let latestMatch = RPSMatch(player1: userRPS, player2: compRPS)
        history.append(latestMatch)
        
        // Now we are ready to segue
        performSegue(withIdentifier: "ResultViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! ResultViewController
        controller.view.backgroundColor  = UIColor.gray
        controller.userMove = self.userRPS
        controller.compMove = self.compRPS
    }
    
    
    @IBAction func showHistory(sender: UIButton) {
        let historyController = self.storyboard!.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
        
        // Debugging history = [RPSMatch](), seems to print out the correct data
        //print("VIEWCONTROLLER history \(history)")
        
        historyController.history = history
        
        // Debugging HistoryViewController's history = [RPSMatch](), seems to print out the correct data
        //print("HISTORYVIEWCONTROLLER history \(historyController.history)")
        
        self.navigationController?.pushViewController(historyController, animated: true)
    }
}

struct RPSMatch {
    let player1: RPS
    let player2: RPS
}

enum RPS: Int {
    case Rock = 0, Paper = 1, Scissors = 2
}

extension RPS {
    static func random() -> RPS {
        let randomValue = Int(arc4random()) % 3
        return RPS(rawValue: randomValue)!
    }
    
    var stringValue: String {
        switch self {
        case .Rock:
            return "ROCK"
        case .Paper:
            return "PAPER"
        case .Scissors:
            return "SCISSORS"
        }
    }
    
    init?(string: String) {
        switch string {
        case "Rock":
            self = .Rock
        case "Paper":
            self = .Paper
        case "Scissors":
            self = .Scissors
        default:
            return nil
        }
    }
    
    func compareTo(other: RPS) -> Int {
        if self == .Rock {
            if (other == .Scissors) {
                //win
                return 1
            }
            else if (other == .Paper){
                //lose
                return -1
            }
            else {
                return 0
            }
        }
        else if self == .Paper {
            if other == .Scissors {
                return -1
            }
            else if (other == .Rock) {
                return 1
            }
            else {
                return 0
            }
        }
        else if self == .Scissors {
            if other == .Paper {
                return 1
            }
            else if (other == .Rock) {
                return -1
            }
            else {
                return 0
            }
        }
        else  {
            return 0
        }
    }
}
