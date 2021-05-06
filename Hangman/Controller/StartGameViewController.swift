//
//  StartGameViewController.swift
//  Hangman
//
//  Created by Yaz Burrell on 5/5/21.
//

import UIKit

class StartGameViewController: UIViewController {

    @IBOutlet weak var hangmanLabel: UILabel!
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var startGameButton: UIButton!
    
    let defaults = UserDefaults.standard
    var totalScore = 0 {
        didSet {
            totalScoreLabel.text = "Total Score: \(totalScore)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let score = defaults.integer(forKey: "TotalScore") as? Int {
            totalScore = score
        } else {
            totalScore = 0
        }
    }
    
  
 
    @IBAction func startGaneButtonPressed(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "startGameSegue", sender: self)
    }
    
    
    
}
