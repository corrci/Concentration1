//
//  ViewController.swift
//  Concentration1
//
//  Created by corrci on 2018/9/9.
//  Copyright © 2018年 corrci. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsCards: numberOfPairsCards)
    
    var numberOfPairsCards: Int{
        return (cardButtons.count + 1) / 2
    }
    
    
    private(set) var flipCount = 0
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBAction private func newGame(_ sender: UIButton) {
        game.resetGame()
        themsIndex = Int.random(in: 0..<keys.count)
        updateViewFromModel()
    }
    @IBOutlet private var cardButtons: [UIButton]!{
        didSet{
            themsIndex = Int.random(in: 0..<keys.count)
        }
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let carNumber = cardButtons.index(of: sender){
            game.chooseCard(at: carNumber)
            updateViewFromModel()
        }else{
            print("chosen card was not in cardButtons")
        }
    }
    private func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUP{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
        scoreLabel.text = "Score:\(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    //private var emojiChoices = ["🍐","🌶","🍌","🌽","🍏","🍓","🍇","🍋","🍉","🥝"]
    
    private var emojiChoices = "🍐🌶🍌🌽🍏🍓🍇🍋🍉🥝"
    
    private var emojiThems  = [
    "fruits" : "🍐🌶🍌🌽🍏🍓🍇🍋🍉🥝",
    "animals" : "🐶🐱🐭🐰🦊🐻🐼🐨🐯🦁",
    "insects" : "🐝🐛🦋🐌🐞🐜🦟🦗🕷🦂",
    "fish" : "🐙🦑🦐🦞🦀🐡🐠🐟🐬🐳",
    "vegetables" : "🍅🍆🥑🥦🥬🥒🌶🌽🥕🥔",
    "desset" : "🥧🧁🍰🍮🍭🍬🍫🍿🍩🍪"
    ]
    
    private var keys : [String] {return Array(emojiThems.keys)}
    
    private var themsIndex = 0{
        didSet{
            emojiChoices = emojiThems[keys[themsIndex]] ?? String()
            emoji = [Int:String]()
        }
    }
    
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0{
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: Int.random(in: 0..<emojiChoices.count))
            emoji[card.identifier] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card.identifier] ?? "?" 
    }
}

//extension Int {
//    var arc4random : Int{
//        if self > 0{
//            return Int(arc4random_uniform(UInt32(self)))
//        }else if self < 0{
//            return -Int(arc4random_uniform(UInt32(abs(self))))
//        }else{
//            return 0
//        }
//    }
//}
