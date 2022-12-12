//
//  StartViewController.swift
//  TicTacToe
//
//  Created by Ahmad Ardal on 2022-09-25.
//

import UIKit

class StartViewController: UIViewController {


    @IBOutlet weak var txtPlayer1: UITextField!
    @IBOutlet weak var txtPlayer2: UITextField!
    
    @IBOutlet weak var switchComputer: UISwitch!
    
    @IBOutlet weak var lblPlayer2: UILabel!
    
    let segueToGame = "segueToGame"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func startGame(_ sender: Any) {
        if txtPlayer1.text?.count == 0 {
            return
        }
        
        if !switchComputer.isOn && txtPlayer2.text?.count == 0 {
            return
        }

        performSegue(withIdentifier: segueToGame, sender: self)
    }
    

    @IBAction func onSwitch(_ sender: UISwitch) {
        txtPlayer2.isHidden = sender.isOn
        lblPlayer2.isHidden = sender.isOn
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destinationVC = segue.destination as? GameViewController else { return }
        guard let player1Name = txtPlayer1.text else { return }
        
        destinationVC.player1 = Player(name: player1Name, number: 1, markerImage: "X", isComputer: false)
        
        if switchComputer.isOn {
            destinationVC.player2 = Player(name: "Computer", number: 2, markerImage: "O", isComputer: true)
        } else {
            guard let player2Name = txtPlayer2.text else { return }
            destinationVC.player2 = Player(name: player2Name, number: 2, markerImage: "O", isComputer: false)
        }
    }

}
