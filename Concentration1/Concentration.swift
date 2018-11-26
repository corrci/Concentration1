//
//  Concentration.swift
//  Concentration1
//
//  Created by corrci on 2018/9/9.
//  Copyright © 2018年 corrci. All rights reserved.
//

import Foundation

struct Concentration{
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            return cards.indices.filter { cards[$0].isFaceUP }.oneAndOnly
//            var foundIndex: Int?
//            for index in cards.indices{
//                if cards[index].isFaceUP{
//                    if foundIndex == nil{
//                        foundIndex = index
//                    }else{
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUP = (index == newValue)
            }
        }
    }
    //get the point
    var score = 0
    var seenCards = [Int]()

    //resetGame
    mutating func resetGame(){
        for index in cards.indices{
            cards[index].isFaceUP = false
            cards[index].isMatched = false
            score = 0
        }
        cards.shuffle()
    }
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chooseCard index not in the cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //check it cards match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }else{
                    if seenCards.contains(index),seenCards.contains(matchIndex){
                        score -= 1
                    }
                    seenCards.append(index)
                    seenCards.append(matchIndex)
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
        cards.shuffle()
    }
}
//extension Array{
//    mutating func shuffle() {
//        for _ in 0..<10{
//            sort{(_,_) in arc4random() < arc4random()}
//        }
//    }
//}

//extension Array{
//    mutating func shuffle() {
//        if count < 2 {return}
//        for i in indices.dropLast(){
//            let diff = distance(from: i, to: endIndex)
//            let j = index(i, offsetBy: diff.arc4random)
//            swapAt(i, j)
//        }
//    }
//}

extension Collection{
    var oneAndOnly: Element?{
        return count == 1 ? first : nil
    }
}
