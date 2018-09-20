//
//  Concentration.swift
//  Concentration1
//
//  Created by corrci on 2018/9/9.
//  Copyright © 2018年 corrci. All rights reserved.
//

import Foundation

class Concentration{
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    func chooseCard(at index: Int){
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //check it cards match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUP = true
                indexOfOneAndOnlyFaceUpCard = nil
            }else{
                // either no cards or two cards are face up
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUP = false
                }
                cards[index].isFaceUP = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    init(numberOfPairsCards: Int) {
        for _ in 1...numberOfPairsCards{
            let card = Card()
            cards += [card,card]
        }
        // shuffle the cards
    }
}
