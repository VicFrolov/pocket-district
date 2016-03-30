//
//  LoginPageViewController.swift
//  Shoes
//
//  Created by Victor Frolov on 12/29/15.
//  Copyright © 2015 Victor Frolov. All rights reserved.
//

import UIKit
import AVFoundation


class LoginPageViewController: UIViewController {
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    

    override func viewDidLoad() {
        //hide the navbar
        UIApplication.sharedApplication().statusBarHidden = true
        
        
        //display video playing in bg
        let theURL = NSBundle.mainBundle().URLForResource("background", withExtension: "mp4")
        
        avPlayer = AVPlayer(URL: theURL!)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = AVPlayerActionAtItemEnd.None
        
        avPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = UIColor.clearColor();
        view.layer.insertSublayer(avPlayerLayer, atIndex: 0)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: #selector(LoginPageViewController.playerItemDidReachEnd(_:)),
            name: AVPlayerItemDidPlayToEndTimeNotification,
            object: avPlayer.currentItem)
        
    }
    
    func playerItemDidReachEnd(notification: NSNotification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seekToTime(kCMTimeZero)
    }
    
    override func viewDidAppear(animated: Bool) {
        avPlayer.play()
        paused = false

        //checking if user has already logged in
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && DataService.dataService.CURRENT_USER_REF.authData != nil {
            self.performSegueWithIdentifier("CurrentlyLoggedIn", sender: nil)
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        avPlayer.pause()
        paused = true
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

