//
//  ViewController.swift
//  NBA Player Compare
//
//  Created by Harrison Shu on 6/23/22.
//

import UIKit

class MainViewController: UIViewController, PlayerDelegate, UITextFieldDelegate {
    

    @IBOutlet weak var playerOnePointsLabel: UILabel!
    @IBOutlet weak var playerOneAssistsLabel: UILabel!
    @IBOutlet weak var playerOneReboundsLabel: UILabel!
    @IBOutlet weak var playerOneBlocksLabel: UILabel!
    @IBOutlet weak var playerOneSearchTextField: UITextField!
    
    @IBOutlet weak var playerTwoPointsLabel: UILabel!
    @IBOutlet weak var playerTwoAssistsLabel: UILabel!
    @IBOutlet weak var playerTwoReboundsLabel: UILabel!
    @IBOutlet weak var playerTwoBlocksLabel: UILabel!
    @IBOutlet weak var playerTwoSearchTextField: UITextField!
    
    let playerDict = PlayerDict()
    let season = Database()
    override func viewDidLoad() {
                super.viewDidLoad()
        season.getPlayer(id: String(playerDict.dict["Alex Abrines"]!), season: "2017", number: 1)
        season.delegate = self
        playerOneSearchTextField.delegate = self
        playerTwoSearchTextField.delegate = self
    }
    
    func updatePlayerOneStats(pd: PlayerDisplay) {
        DispatchQueue.main.async {
            print(pd)
            self.playerOnePointsLabel.text = String(format: "PPG: %.1f", pd.ppg)
            self.playerOneAssistsLabel.text = String(format: "APG: %.1f", pd.apg)
            self.playerOneReboundsLabel.text = String(format: "RPG: %.1f", pd.rpg)
            self.playerOneBlocksLabel.text = String(format: "BPG: %.1f", pd.bpg)
        }
    }
    
    func updatePlayerTwoStats(pd: PlayerDisplay) {
        DispatchQueue.main.async {
            print(pd)
            self.playerTwoPointsLabel.text = String(format: "PPG: %.1f", pd.ppg)
            self.playerTwoAssistsLabel.text = String(format: "APG: %.1f", pd.apg)
            self.playerTwoReboundsLabel.text = String(format: "RPG: %.1f", pd.rpg)
            self.playerTwoBlocksLabel.text = String(format: "BPG: %.1f", pd.bpg)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if playerOneSearchTextField.isFirstResponder {
            season.getPlayer(id: String(playerDict.dict[playerOneSearchTextField.text!]!), season: "2017", number: 1)
            playerOneSearchTextField.endEditing(true)
            return true
        } else if playerTwoSearchTextField.isFirstResponder {
            season.getPlayer(id: String(playerDict.dict[playerTwoSearchTextField.text!]!), season: "2017", number: 2)
            playerTwoSearchTextField.endEditing(true)
            return true
    
        }
        
        return false
    }

}
