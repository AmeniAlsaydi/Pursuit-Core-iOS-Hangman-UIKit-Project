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
    
    
    // creating a game instance
    let game = HangmanBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        wordEntry.delegate = self
        letterGuess.delegate = self
        
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // I need to specify that this is the first text feild.
       if textField == wordEntry {
            guard let word = textField.text else { return false }
            game.enteredWord = word
            
            textField.text = ""
            textField.placeholder = "Word Entered"
            game.hiddenWord = game.getHiddenWord()
            hiddenWordLabel.text = game.hiddenWord.joined(separator:" ")
            textField.isEnabled = false
            
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == letterGuess {
        textField.text = ""
        game.checkEntry(string)
        let image = game.chnageImage()
        hangImage.image = image
        hiddenWordLabel.text = game.hiddenWord.joined(separator:" ")
        print("hidden word: \(game.hiddenWord)")
        
        let newLength = (textField.text?.characters.count ?? 2) + string.characters.count - range.length
        return newLength <= 1 // replace 30 for your max length value

       }
        
    return true
    }
    
    
}

