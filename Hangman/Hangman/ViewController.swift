//
//  ViewController.swift
//  Hangman
//
//  Created by Alex Paul on 11/19/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var wordEntry: UITextField!
    @IBOutlet weak var hiddenWordLabel: UILabel!
    @IBOutlet weak var letterGuess: UITextField!
    @IBOutlet weak var hangImage: UIImageView!
    @IBOutlet weak var winLoseLabel: UILabel!
    @IBOutlet weak var playAgain: UIButton!
    
    var enteredLetters = [String]()
    
    // creating a game instance
    let game = HangmanBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        wordEntry.delegate = self
        letterGuess.delegate = self
        letterGuess.isEnabled = false
    }
    
    
    @IBAction func playAgain(_ sender: UIButton) {
        game.newGame()
        wordEntry.isEnabled = true
        letterGuess.isEnabled = true
        hiddenWordLabel.text = ""
        wordEntry.placeholder = "Enter Word"
        letterGuess.placeholder = ""
        hangImage.image = game.hangImage
        winLoseLabel.text = ""
        letterGuess.isEnabled = false
        enteredLetters = [String]()
        playAgain.setImage(nil, for: .normal)

    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == wordEntry {
            guard let word = textField.text else { return false }
            game.enteredWord = word
            
            textField.text = ""
            textField.placeholder = "Word Entered"
            game.hiddenWord = game.getHiddenWord()
            hiddenWordLabel.text = game.hiddenWord.joined(separator:" ")
            textField.isEnabled = false
            letterGuess.isEnabled = true
            
        }
        if textField == letterGuess {
            
            guard let entry = textField.text else { return false }
            print(entry)

            game.checkEntry(entry)
            enteredLetters.append(entry)
            
            textField.text = ""
            hangImage.image = game.chnageImage()
            hiddenWordLabel.text = game.hiddenWord.joined(separator:" ")
            print("hidden word: \(game.hiddenWord)")
            
            print(game.winOrLose)
            
            if game.winOrLose == "win" {
                textField.isEnabled = false
                resignFirstResponder()
                winLoseLabel.text = "WINNER! 🏆"
                textField.placeholder = "Play Again!"
                playAgain.setImage(UIImage(named: "playAgainButton"), for: .normal)
                
            } else if game.winOrLose == "lose" {
                textField.isEnabled = false
                resignFirstResponder()
                winLoseLabel.text = "YOU LOSE! 😭 The word was: \(game.enteredWord)"
                textField.placeholder = "Play Again!"
                playAgain.setImage(UIImage(named: "playAgainButton"), for: .normal)
            }
            
            
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.count > 1 {
            return false
        }
        
        if textField == letterGuess {
            print(string)
            // Disables the backspace button
            if let char = string.cString(using: String.Encoding.utf8) {
                let isBackSpace = strcmp(char, "\\b")
                if (isBackSpace == -92) {
                    print("Backspace was pressed")
                    return false
                }
            }
            
            // Disables letter keys that have already been entered
            if enteredLetters.contains(string) {
                print("this has already been entered ")
                return false
            }
            
            // Disables keys that are not letters a-z
            if !Character(string).isLetter { return false }
            
            // Disable from entering more than 1 letter:
            let newLength = (textField.text?.count ?? 1) + string.count - range.length
            return newLength <= 1
        }
        
        return true
    }

}

