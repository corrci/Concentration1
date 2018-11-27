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
    private(set) var score = 0
    private var seenCards = [Int]()
    
    private(set) var flipCount = 0

    //resetGame
    mutating func resetGame(){
        for index in cards.indices{
            cards[index].isFaceUP = false
            cards[index].isMatched = false
            score = 0
            flipCount = 0
        }
        cards.shuffle()
    }
    
    //time rule
    private var dateClick : Date?
    private var timePenalty : Int{
        return min(dateClick?.sinceNow ?? 0 , Point.maxTimePenalty)
    }
    struct Point {
        static let matchBonus = 20
        static let missMatchPenalty = 10
        static let maxTimePenalty = 10
    }
    
    
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chooseCard index not in the cards")
        flipCount += 1
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //check it cards match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    //match get 2 point
                    score += Point.matchBonus
                }else{
                    //!match and have seen lost  point
                    if seenCards.contains(index),seenCards.contains(matchIndex){
                        score -= Point.missMatchPenalty
                    }
                    seenCards.append(index)
                    seenCards.append(matchIndex)
                }
                score -= timePenalty
                cards[index].isFaceUP = true
            }else{
                // either no cards or two cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
            dateClick = Date()
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

extension Date{
    var sinceNow : Int{
        return -Int(self.timeIntervalSinceNow)
    }
}
