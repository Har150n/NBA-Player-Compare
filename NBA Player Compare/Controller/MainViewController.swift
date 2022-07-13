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
    override func viewDidLoad() {
        let playerDict = PlayerDict()
        super.viewDidLoad()
        let season = Database()
        season.getPlayer(id: String(playerDict.dict["Devin Booker"]!), season: "2017")
        season.delegate = self
        playerOneSearchTextField.delegate = self
    }
    
    func updateStats(pd: PlayerDisplay) {
        DispatchQueue.main.async {
            print(pd)
            self.playerOnePointsLabel.text = String(format: "PPG: %.1f", pd.ppg)
            self.playerOneAssistsLabel.text = String(format: "APG: %.1f", pd.apg)
            self.playerOneReboundsLabel.text = String(format: "RPG: %.1f", pd.rpg)
            self.playerOneBlocksLabel.text = String(format: "BPG: %.1f", pd.bpg)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(playerOneSearchTextField.text!)
        playerOneSearchTextField.endEditing(true)
        return true
    }
    
}

