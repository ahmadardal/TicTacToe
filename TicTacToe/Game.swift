//
//  Game.swift
//  TicTacToe
//
//  Created by Ahmad Ardal on 2022-09-06.
//

import Foundation


struct Player {
    var name: String
    var number: Int
    var markerImage: String
    var isComputer: Bool
}

class Game {
    
    let GAME_CONTINUE = 0, CELL_EMPTY = 0
    let RESULT_PLAYER1 = 1
    let RESULT_PLAYER2 = 2
    let RESULT_DRAW = 3
    let GAME_ENDED = 4
    
    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
        self.currentPlayer = player1
        self.gameStatus = GAME_CONTINUE
    }
    
    var board = [0, 0, 0, 0, 0, 0, 0, 0, 0]

    
    
    var player1: Player
    var player2: Player
    
    var gameStatus: Int
    
    var previousPlayer: Player?
    var currentPlayer: Player
    
    
    func endGame(result: Int) -> Int {
        switchPlayer()
        gameStatus = result
        return result
    }
    
    
    
    func switchPlayer() {
        if currentPlayer.number == 1 {
            previousPlayer = player1
            currentPlayer = player2
        } else {
            previousPlayer = player2
            currentPlayer = player1
        }
    }
    
    func addMove(position: Int) -> Int {
        
        if gameStatus != GAME_CONTINUE {
            return GAME_ENDED
        }
        
        if board[position] != 0 {
            return GAME_CONTINUE
        }
        
        print("Selected: \(currentPlayer.number)")
        
        board[position] = currentPlayer.number
        
        let result = getGameResult()
        
        if result != GAME_CONTINUE {
            return endGame(result: result)
        }

        var count = 0
        
        for cell in board {
            if cell != 0 {
                count += 1
            }
        }
        
        if count > 8 {
            return endGame(result: RESULT_DRAW)
        }
        
        switchPlayer()
        
        
        return GAME_CONTINUE
    }
    
    func getGameResult() -> Int {

        print(board)
        // Row 1
    
        if board[0] == board[1] && board[0] == board[2] && board[0] != 0 {
            print("Player \(board[0]) has won!")
            return board[0]
        }
        
        // Row 2
        
        if board[3] == board[4] && board[3] == board[5] && board[3] != 0 {
            print("Player \(board[3]) has won!")
            return board[3]
        }
        
        // Row 3
        
        if board[6] == board[7] && board[6] == board[8] && board[6] != 0 {
            print("Player \(board[6]) has won!")
            return board[6]
        }
        
        // Column 1
        
        if board[0] == board[3] && board[0] == board[6] && board[0] != 0 {
            print("Player \(board[0]) has won!")
            return board[0]
        }
        
        // Column 2
        
        if board[1] == board[4] && board[1] == board[7] && board[1] != 0 {
            print("Player \(board[0]) has won!")
            return board[0]
        }
        
        // Column 3
        
        if board[2] == board[5] && board[2] == board[8] && board[2] != 0 {
            print("Player \(board[2]) has won!")
            return board[0]
        }
        
        // Diagonal row
        
        if board[0] == board[4] && board[0] == board[8] && board[0] != 0 {
            print("Player \(board[0]) has won!")
            return board[0]
        }
        
        if board[2] == board[4] && board[2] == board[6] && board[2] != 0 {
            print("Player \(board[2]) has won!")
            return board[2]
        }
    
        return GAME_CONTINUE
    }
    
    
}
