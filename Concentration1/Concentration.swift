//
//  Concentration.swift
//  Concentration1
//
//  Created by corrci on 2018/9/9.
//  Copyright © 2018年 corrci. All rights reserved.
//

import Foundation

class Concentration{
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFaceUP{
                    if foundIndex == nil{
                        foundIndex = index
                    }else{
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUP = (index == newValue)
            }
        }
    }
    func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chooseCard index not in the cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //check it cards match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUP = true
            }else{
                // either no cards or two cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    init(numberOfPairsCards: Int) {
        assert(numberOfPairsCards > 0, "Concentration.init(\(numberOfPairsCards)): you must have a least one pair of cards")
        for _ in 1...numberOfPairsCards{
            let card = Card()
            cards += [card,card]
        }
        // shuffle the cards
    }
}
