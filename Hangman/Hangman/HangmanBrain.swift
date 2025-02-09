//
//  HangmanBrain.swift
//  Hangman
//
//  Created by Amy Alsaydi on 11/14/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class HangmanBrain { // maybe this is better off as a stuct so things dont have to initialized. ????
    var hiddenWord = [String]()
    var enteredWord = ""
    var wrongCount = 0
    var hangImage = #imageLiteral(resourceName: "hang1")
    var winOrLose = ""
    
    
    
    func getHiddenWord() -> [String] {
        
        hiddenWord = Array(repeating: "_", count: enteredWord.count)
        return hiddenWord
    }
    
    func checkEntry(_ letter: String) { // could this return a string winOrLose
        // print(letter)
        
        let enteredWord = self.enteredWord.lowercased()
        let letter = letter.lowercased()
        
        var spotCounter = 0
        
        if enteredWord.contains(letter) { // checks if word contains the letter entered
                        
            for char in enteredWord { // loops through the word
                
                if letter == String(char) { // checks if user letter is = to char in word
                    hiddenWord[spotCounter] = letter
                }
                spotCounter += 1
            }
            
            
        } else {
        wrongCount += 1
        }
        
        if hiddenWord.joined(separator: "") == enteredWord {
                winOrLose = "win"
                // change label
                // disable text feild for guess entry
            } else if wrongCount == 6 {
                winOrLose = "lose"
                // print loss on label
                // disable text feild for guess entry

            }
        }

    func chnageImage() -> UIImage {
        switch wrongCount {
        case 0:
            hangImage = #imageLiteral(resourceName: "hang1")
        case 1:
            hangImage = #imageLiteral(resourceName: "hang2")
        case 2:
            hangImage = #imageLiteral(resourceName: "hang3")
        case 3:
            hangImage = #imageLiteral(resourceName: "hang4")
        case 4:
            hangImage = #imageLiteral(resourceName: "hang5")
        case 5:
            hangImage = #imageLiteral(resourceName: "hang6")
        case 6:
            hangImage = #imageLiteral(resourceName: "hang7")
        default:
            print("out of range" )
        }
        return hangImage
    }
    
    func newGame() {

        hiddenWord = [String]()
        enteredWord = ""
        wrongCount = 0
        hangImage = #imageLiteral(resourceName: "hang1")
        winOrLose = ""
        
    }

}
