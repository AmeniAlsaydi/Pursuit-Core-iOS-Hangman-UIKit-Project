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
    
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        wordEntry.isEnabled = true
        letterGuess.isEnabled = true
        hiddenWordLabel.text = ""
        wordEntry.placeholder = "Enter Word"
        letterGuess.placeholder = ""
        hangImage.image = game.hangImage
        winLoseLabel.text = ""
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
                winLoseLabel.text = "You win"
                textField.placeholder = "Play Again!"
            } else if game.winOrLose == "lose" {
                textField.isEnabled = false
                resignFirstResponder()
                winLoseLabel.text = "You lose"
                textField.placeholder = "Play Again!"
            }
            
            
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
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
            
            let newLength = (textField.text?.count ?? 1) + string.count - range.length
            return newLength <= 1
        }
        
        return true
    }

}

// TODO:
/*
 - disable delete button ✅
 - stop users from entering in anything except for the letters a-z
 - stop user from entering a letter that has already been guessed ✅
 - BUG: when i enter the 'i' its capitalized and will not check for i correctly
 */
