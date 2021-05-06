//
//  GameViewController.swift
//  Hangman
//
//  Created by Yaz Burrell on 5/5/21.
//

import UIKit

class GameViewController: UIViewController, GameProtocol {
    
  

    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var hangmanImageView: UIImageView!
    @IBOutlet weak var guessesLeftLabel: UILabel!
    @IBOutlet var lettersButtons: [UIButton]!
    @IBOutlet weak var wordLabel: UILabel!
    
    ///havent sent the word label anywhere
    
    
    //Save user score
    let defaults = UserDefaults.standard
    var totalScore = 0 {
        didSet{
            defaults.set(totalScore, forKey: "TotalScore")
        }
    }
    
    let gameManager = GameManager()
    var letterArray = [String]()
    var word = ""
    
    var hiddenWord = ""
    var hiddenWordArray = [String]()
    
    var wordStrings = [String]()
    var usedLetters = ""
    var wordCompleted = false
    var round = 0
    
    let image = "hangman"
    
    
    
    var hangmanImageNumber = 0 {
        didSet{
            hangmanImageView.image = UIImage(named: "\(image)\(hangmanImageNumber)")
        }
    }
    
    var score = 0 {
        didSet {
            currentScoreLabel.text = "\(score) points"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameManager.fetchData()
        
        if let score = defaults.integer(forKey: "TotalScore") as? Int {
            totalScore = score
        } else {
            totalScore = 0
        }
    }
    func gameDataFetched(_ data: [String]) {
        wordStrings += data
        loadWord()
    }
    var livesLeft = 10 {
        didSet {
            guessesLeftLabel.text = "Lives Left: \(livesLeft)"
        }
    }
    
    @IBAction func letterPressed(_ sender: UIButton){
        guard let letterChosen = sender.currentTitle?.lowercased() else { return }
        
        usedLetters.append(letterChosen)
        
        if letterArray.contains(letterChosen){
            for (index, letter) in letterArray.enumerated() {
                if letterChosen == letter {
                    hiddenWordArray[index] = letter
                }
            }
            
            hiddenWord = hiddenWordArray.joined()
            score += 1
            totalScore += 1
        } else {
            score -= 1
            totalScore -= 1
            hangmanImageNumber += 1
            livesLeft -= 1
        }
        //used letters used are different color if selected
        sender.isEnabled = false
        sender.setTitleColor(UIColor.red, for: .disabled)
        wordLabel.text = hiddenWord
        
//        gameStatusCheck()
        
        if livesLeft <= 1 {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
        if wordCompleted {
            for button in lettersButtons {
                button.isEnabled = true
                navigationItem.rightBarButtonItem?.isEnabled = true
            }
            wordCompleted = false
        }
    }
    
    
    func gameStatusCheck() {
        if livesLeft > 0 {
            if hiddenWord == word {
                
                let winningAlert = UIAlertController(title: "VICTORY!", message: "You guessed the word!", preferredStyle: .alert)
                
                winningAlert.addAction(UIAlertAction(title: "Restart Game", style: .default, handler: nil))
                winningAlert.addAction(UIAlertAction(title: "Exit", style: .cancel, handler: nil))
                print("Winning Alert")
                
                
                self.present(winningAlert, animated: true)
                nextRound()
            }
        } else {
            let losingAlert = UIAlertController(title: "AWW SHUCKS", message: "You got got by the hangman. The word you were looking for was \(word)", preferredStyle: .alert)
            losingAlert.addAction(UIAlertAction(title: "Restart Game", style: .default, handler: nil))
            
            
            self.present(losingAlert, animated: true)
            nextRound()
        }
    }
    
    func loadWord() {
        
        letterArray = [String]()
        word = ""
        hiddenWord = ""
        hiddenWordArray = [String]()
        
        livesLeft = 10
        hangmanImageNumber = 0
        
        //  Save word into an array + string
        word = wordStrings[round]
        for letter in wordStrings[round] {
            letterArray.append(String(letter))
        }
        
        print(letterArray)
        print(word)
        
        for _ in 0..<letterArray.count {
            hiddenWord  += "?"
            hiddenWordArray.append("?")
        }
        
        wordLabel.text = hiddenWord
    }

    func nextRound() {
        round += 1
        wordCompleted = true
    }
}
