//
//  ViewController.swift
//  Concentration
//
//  Created by Joseph Benton on 1/24/18.
//  Copyright © 2018 josephtbenton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func newGame(_ sender: UIButton) {
        setRandomTheme()
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var themes = [
        ["🤡", "🤠", "👩‍💻", "👩‍🚒", "👨‍✈️", "👨‍🎨", "🕺", "👩‍🏫"],
        ["A", "B", "C", "D", "E", "F", "G", "H"],
        ["1", "2", "3", "4", "5", "6", "7", "8"],
        ["🐘", "🐲", "🐇", "🐄", "🦐", "🐍", "🦀", "🕷"],
        ["🌪", "🌊", "💦", "⛄️", "🌈", "🔥", "☁️", "☀️"],
        ["🍎", "🍌", "🍇", "🌶", "🥕", "🍒", "🥑", "🍓"]
    ]
    
    lazy var emojiChoices: [String] = themes[0]
    
    var emoji = [Int: String]()
    
    func setRandomTheme() {
        let themeIndex = Int(arc4random_uniform(UInt32(themes.count )))
        emojiChoices = themes[themeIndex]
        emoji = [Int: String]()
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count - 1)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    
}

