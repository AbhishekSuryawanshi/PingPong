//
//  MenuVC.swift
//  JustJump
//
//  Created by Abhishek Suryawanshi on 04/09/17.
//  Copyright © 2017 iOSDevelopment. All rights reserved.
//

import Foundation
import UIKit

enum gameType {
    case easy
    case medium
    case hard
    case player2
}

class MenuVC: UIViewController {
    
    
    @IBAction func player2(_ sender: Any) {
        moveToGmae(game: .player2)
    }
    
    @IBAction func easy(_ sender: Any) {
        moveToGmae(game: .easy)
    }
    
    @IBAction func medium(_ sender: Any) {
        moveToGmae(game: .medium)
    }
    
    @IBAction func hard(_ sender: Any) {
        moveToGmae(game: .hard)
    }
    
    func moveToGmae(game : gameType) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game
        
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
}
