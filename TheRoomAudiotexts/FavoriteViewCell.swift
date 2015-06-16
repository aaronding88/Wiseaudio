//
//  FavoriteViewCell.swift
//  TheRoomAudiotexts
//
//  Created by Aaron Ding on 5/14/15.
//  Copyright (c) 2015 Aaron Ding. All rights reserved.
//

import UIKit
import AVFoundation

// The favorite view cell populates each individual cell. First View Controller passes information to each cell,
// and each cell will have unique outlets, and actions will communicate with the view controller.
class FavoriteViewCell: UICollectionViewCell {

    var soundList : AudioList?
    
    var viewController : FirstViewController?
    
    // Stores the audio file link.
    var audioNSUrl : NSURL?
    
    var timer : NSTimer!
    
    var audioPlayer : AVAudioPlayer?
    
    var isPlaying : Bool = false
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBOutlet weak var imgLabel: UIImageView!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    // A custom initializer that is called when the cell is repopulated. It will reset everything to a default.
    func initialize(audioObj: AudioObject, viewController: FirstViewController) {
        self.viewController = viewController
        let defaults = NSUserDefaults.standardUserDefaults()
        titleLabel.text = audioObj.title
        quoteLabel.text = audioObj.audioDescription
        imgLabel.image = UIImage(named: audioObj.imgName)
        audioNSUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(audioObj.fileName, ofType: "mp4")!)
        audioPlayer = AVAudioPlayer(contentsOfURL: audioNSUrl, error: nil)
        progressBar.progress = 0
        isPlaying = false
    }
    
    // Internal function that updates the progress timer.
    func updateProgress(timer: NSTimer!) {
        
        // Finds the percentage of the how much the audio is completed, and downcasts it to a Float.
        var currentProgress : Float = Float((audioPlayer!.currentTime / audioPlayer!.duration))
        
        // Sets the progress to the percentage of total time played.
        progressBar.setProgress(currentProgress, animated: false)
        
        // If the progress reaches 1, audio is done, and invalidate the timer.
        // Alternatively, you could use the "optional func audioPlayerDidFinishPlaying" too.
        if (progressBar.progress >= 0.98) {
            progressBar.progress = 0
            timer.invalidate()
            isPlaying = false
            println("Timer ended: Sound restarted")
        }
    }
    @IBAction func shareAudio(sender: AnyObject) {
        if let urlFile = audioNSUrl {
            let fixedFile = [urlFile]
            let activityVC = UIActivityViewController(activityItems: fixedFile, applicationActivities: nil)
            if (viewController != nil) {
                // Excludes the following: Reading list, Copy to pasteboard, Vimeo, Print, Saving, Airdrop.
                //#Explanation: The purpose isn't to encourage saving audio, though it will be possible. The idea
                // is that we want the App to contain all the files, not the phone.
                self.viewController!.presentViewController(activityVC, animated: true, completion: nil)
                activityVC.excludedActivityTypes = [UIActivityTypeAddToReadingList, UIActivityTypeCopyToPasteboard, UIActivityTypePostToVimeo, UIActivityTypePrint, UIActivityTypeSaveToCameraRoll, UIActivityTypeAirDrop]
            } else {
                println("No View Controller passed!")
            }
        }
        else {
            println("No AudioNSUrl passed!")
        }
    }
    
    @IBAction func playAudio(sender: AnyObject) {
        
        
        // Links the audio file to the variable.
        if !isPlaying && progressBar.progress > 0 {
            audioPlayer!.play()
            println("Should restart at current time.")
            isPlaying = true
        }
            
        else if !isPlaying && progressBar.progress == 0{
            // Schedules the timer to prime every few intervals and fires the selector. It will not invalidate until manually called.
            timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector: "updateProgress:" , userInfo: nil, repeats: true)
            audioPlayer!.play()
            isPlaying = true
            println("Restarted Audio")
        }
        else {
            audioPlayer!.pause()
            isPlaying = false
            println("Paused")
        }

    }
    @IBAction func removeFromFavorites(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(false, forKey: titleLabel.text!)
        viewController?.removeFromFavorites(titleLabel.text!)
        viewController?.favoriteCollectionView.reloadData()
    }
}
