//
//  ViewController.swift
//  TicTacToe
//
//  Created by Ahmad Ardal on 2022-09-06.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var lblTop: UILabel!
    
    @IBOutlet var cellButtons: [UIButton]!
    @IBOutlet weak var btnPlayOrReset: UIButton!
    
    var game: Game?
    
    var player1: Player?
    var player2: Player?
    
//    var player1 = Player(name: "Ahmad", number: 1, markerImage: "X")
//    var player2 = Player(name: "Mahmod", number: 2, markerImage: "O")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let player1 = player1,
           let player2 = player2 {
            game = Game(player1: player1, player2: player2)
        } else {
            return
        }

        lblTop.text = "\(game?.currentPlayer.name ?? "No player")'s turn!"
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            UIView.animate(withDuration: 1.0, animations: {self.lblTop.alpha = 1.0}, completion: nil)
        }
    }
    
    
    @IBAction func onPlayOrReset(_ sender: Any) {
        if let player1 = player1,
           let player2 = player2 {
            
            game = Game(player1: player1, player2: player2)
            
            for button in cellButtons {
                button.setBackgroundImage(nil, for: .normal)
            }
            btnPlayOrReset.setTitle("Reset", for: .normal)
        }
    }
    
    func computerMove() {
        
        var freeCells = [Int]()
        
        if let game = game {
            for cell in game.board {
                if game.board[cell] == 0 {
                    freeCells.append(cell)
                }
            }
        }
        
        if freeCells.count == 0 {
            return
        }
        
        let randomIndex = Int.random(in: 0...(freeCells.count-1))
        
        let selectedButton = cellButtons[randomIndex]
        
        onCellSelected(selectedButton)
        
    }
    
    @IBAction func onCellSelected(_ sender: UIButton) {
        
        if let game = game {

            let result = game.addMove(position: sender.tag)
            print("PSelected: \(game.previousPlayer?.number ?? 5)")

            
            switch result {
            case game.GAME_CONTINUE:
                sender.setBackgroundImage(UIImage.init(named: game.previousPlayer?.markerImage ?? ""), for: .normal)
                lblTop.text = "\(game.currentPlayer.name)'s turn!"
                
                if game.player2.isComputer {
                    computerMove()
                }
                
            case game.RESULT_DRAW:
                sender.setBackgroundImage(UIImage.init(named: game.previousPlayer?.markerImage ?? ""), for: .normal)
                lblTop.text = "Game is a draw!"
                btnPlayOrReset.setTitle("Play again", for: .normal)
            case game.RESULT_PLAYER1:
                sender.setBackgroundImage(UIImage.init(named: game.previousPlayer?.markerImage ?? ""), for: .normal)
                lblTop.text = "\(game.player1.name) has won!"
                btnPlayOrReset.setTitle("Play again", for: .normal)
            case game.RESULT_PLAYER2:
                sender.setBackgroundImage(UIImage.init(named: game.previousPlayer?.markerImage ?? ""), for: .normal)
                lblTop.text = "\(game.player2.name) has won!"
                btnPlayOrReset.setTitle("Play again", for: .normal)
            case game.GAME_ENDED:
                lblTop.text = "Game has already ended!"
                print("Game has already ended!")
            default: lblTop.text = "Error!"
            }
            
        }

        
    }
    
}

