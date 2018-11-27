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
    
    @IBOutlet weak var themsLabel: UILabel!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBAction private func newGame(_ sender: UIButton) {
        game.resetGame()
        updateUI()
        updateViewFromModel()
    }
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let carNumber = cardButtons.index(of: sender){
            game.chooseCard(at: carNumber)
            updateViewFromModel()
        }else{
            print("chosen card was not in cardButtons")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI(){
        themsIndex = Int.random(in: 0..<emojiThems.count)
        themsLabel.text = emojiThems[themsIndex].name
        themsLabel.textColor = emojiThems[themsIndex].buttonsColor
        flipCountLabel.textColor = emojiThems[themsIndex].buttonsColor
        scoreLabel.textColor = emojiThems[themsIndex].buttonsColor
        newGameButton.backgroundColor = emojiThems[themsIndex].buttonsColor
        for index in cardButtons.indices{
            cardButtons[index].backgroundColor = emojiThems[themsIndex].buttonsColor
        }
        view.backgroundColor = emojiThems[themsIndex].backgroundColor
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
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : emojiThems[themsIndex].buttonsColor
            }
        }
        scoreLabel.text = "Score:\(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    
    private var emojiChoices = "🍐🌶🍌🌽🍏🍓🍇🍋🍉🥝"
    
    private struct Thems {
        var name: String
        var emoji: String
        var textColer: UIColor
        var buttonsColor: UIColor
        var backgroundColor: UIColor
    }
    
    private var emojiThems: [Thems] = [
        Thems(name: "Fruits", emoji: "🍐🌶🍌🌽🍏🍓🍇🍋🍉🥝", textColer: #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1), buttonsColor: #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1), backgroundColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)),
        Thems(name: "Animals", emoji: "🐶🐱🐭🐰🦊🐻🐼🐨🐯🦁", textColer: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), buttonsColor: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)),
        Thems(name: "Insects", emoji: "🐝🐛🦋🐌🐞🐜🦟🦗🕷🦂", textColer: #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1), buttonsColor: #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1), backgroundColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)),
        Thems(name: "Fish", emoji: "🐙🦑🦐🦞🦀🐡🐠🐟🐬🐳", textColer: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), buttonsColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), backgroundColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
        Thems(name: "Vegetables", emoji: "🍅🍆🥑🥦🥬🥒🌶🌽🥕🥔", textColer: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), buttonsColor: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), backgroundColor: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)),
        Thems(name: "Desset", emoji: "🥧🧁🍰🍮🍭🍬🍫🍿🍩🍪", textColer: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), buttonsColor: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), backgroundColor: #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1))
    ]
    
    private var themsIndex = 0{
        didSet{
            emojiChoices = emojiThems[themsIndex].emoji
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
