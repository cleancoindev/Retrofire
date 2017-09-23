//
//  GameViewController.swift
//  Retrofire
//
//  Created by Theo Turner on 04/08/2017.
//  Copyright © 2017 Turner Dhir LLP. All rights reserved.
//

import GoogleMobileAds
import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, GADBannerViewDelegate {
    
    var bannerView:GADBannerView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        bannerView.adUnitID = "ca-app-pub-3666894956061769/4145467379"
        bannerView.rootViewController = self
        bannerView.delegate = self
        bannerView.frame.origin.y = UIScreen.main.bounds.size.height - bannerView.frame.size.height
        bannerView.load(GADRequest())
        
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "MenuScene") {
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
        }
        
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        
        bannerView.alpha = 0
        view.addSubview(bannerView)
        UIView.animate(withDuration: 1, animations: {
            self.bannerView.alpha = 1
        })
        
    }
    
    override func viewWillLayoutSubviews() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showAd), name: NSNotification.Name(rawValue: "showAd"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.hideAd), name: NSNotification.Name(rawValue: "hideAd"), object: nil)
        
    }
    
    @objc func showAd() {
        
        bannerView.isHidden = false
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            self.bannerView.alpha = 1
        })
        
    }
    
    @objc func hideAd() {
        
        UIView.animate(withDuration: 1, animations: {
            self.bannerView.alpha = 0
        })
        bannerView.isHidden = true
        
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
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
