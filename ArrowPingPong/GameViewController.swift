//
//  GameViewController.swift
//  JustJump
//
//  Created by Abhishek Suryawanshi on 28/08/17.
//  Copyright © 2017 iOSDevelopment. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds
import AVFoundation

var currentGameType = gameType.medium

class GameViewController: UIViewController, GADInterstitialDelegate {
    
    var backgroundMusicPlayer = AVAudioPlayer()
    
    var interstitial: GADInterstitial!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        interstitial = createAndLoadInterstitial()
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/1033173712")
        //unit ID: ca-app-pub-5273824607653624/2015583352
        interstitial.delegate = self
        let request = GADRequest()
        interstitial.load(request)
        
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
   
            if let scene = SKScene(fileNamed: "GameScene") {
                 //Set the scale mode to scale to fit the window
                
                do {
                    backgroundMusicPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "background", ofType: "mp3")!))
                    backgroundMusicPlayer.prepareToPlay()
                    backgroundMusicPlayer.play()
                } catch {
                    print(error)
                }
                
                scene.scaleMode = .aspectFill
                
                scene.size = view.bounds.size
                
                
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/1033173712")
        //unit ID: ca-app-pub-5273824607653624/2015583352
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    
    

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    

    @IBAction func backBtn(_ sender: Any) {
        backgroundMusicPlayer.stop()
        
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }
    
    
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
