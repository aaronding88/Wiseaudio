//
//  QuotesCollectionViewCell.swift
//  Wiseaudio
//
//  Created by Aaron Ding on 5/26/15.
//  Copyright (c) 2015 Aaron Ding. All rights reserved.
//

import UIKit
import AVFoundation

class QuotesCollectionViewCell: UICollectionViewCell, AVAudioPlayerDelegate {
    
    var viewController : ThirdViewController?
    
    var audioObj : AudioObject?
    
    var audioNSUrl : NSURL?
    
    var audioPlayer : AVAudioPlayer?
    
    var timer : NSTimer!
    
    private var isPlaying : Bool = false
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBOutlet weak var imgLabel: UIImageView!
    
    @IBOutlet weak var favoritesOutlet: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    // A custom initializer that is called when the cell is repopulated. It will reset everything to a default.
    func initialize(audioObj: AudioObject, viewController: ThirdViewController) {
        self.viewController = viewController
        self.audioObj = audioObj
        let defaults = NSUserDefaults.standardUserDefaults()
        titleLabel.text = audioObj.title
        quoteLabel.text = audioObj.audioDescription
        imgLabel.image = UIImage(named: audioObj.imgName)
        audioNSUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(audioObj.fileName, ofType: "mp4")!)
        audioPlayer = AVAudioPlayer(contentsOfURL: audioNSUrl, error: nil)
        favoritesOutlet.selected = defaults.boolForKey(audioObj.title)
        progressBar.progress = 0
        isPlaying = false
    }
    
    // Shares via ActivityViewController. Attempts to exclude certain types of shares.
    @IBAction func shareSound(sender: UIButton) {
        if let urlFile = audioNSUrl {
            // Casts the urlFile into an array, allowing it to be used in UIActivityViewController.
            let fixedFile = [urlFile]
            let activityVC = UIActivityViewController(activityItems: fixedFile, applicationActivities: nil)
            if (viewController != nil) {
                self.viewController!.presentViewController(activityVC, animated: true, completion: nil)
                // Excludes the following: Reading list, Copy to pasteboard, Vimeo, Print, Saving, Airdrop.
                //#Explanation: The purpose isn't to encourage saving audio, though it will be possible. The idea
                // is that we want the App to contain all the files, not the phone.
                activityVC.excludedActivityTypes = [
                    UIActivityTypePostToWeibo,
                    UIActivityTypeMail,
                    UIActivityTypePrint,
                    UIActivityTypeCopyToPasteboard,
                    UIActivityTypeAssignToContact,
                    UIActivityTypeSaveToCameraRoll,
                    UIActivityTypeAddToReadingList,
                    UIActivityTypePostToFlickr,
                    UIActivityTypePostToVimeo,
                    UIActivityTypePostToTencentWeibo]
            } else {
                println("No View Controller passed!")
            }
        }
        else {
            println("No AudioNSUrl passed!")
        }
    }
    
    func updateProgress(timer: NSTimer!) {
        // Finds the percentage of how much the audio is completed, and downcasts it to a Float.
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
    @IBAction func addToFavorites(sender: AnyObject) {
        // Saves audio file NSURL directly to the favorites NSUser defaults.
        let defaults = NSUserDefaults.standardUserDefaults()
        // Item is not favorited, add to favorites array.
        if (!defaults.boolForKey(titleLabel.text!)) {
            // Saves this check into NSUserDefaults.
            defaults.setBool(true, forKey: titleLabel.text!)
            //println("Favorites set to  \(defaults.boolForKey(titleLabel.text!)) for  \(titleLabel.text!)")
            
            // Creates a new AudioObject to insert to favorites Array.
            var newObj = AudioObject(title: audioObj!.title, audioDescription: audioObj!.audioDescription, fileName: audioObj!.fileName, imgName: audioObj!.imgName, favorite: audioObj!.favorite, isQuote: audioObj!.isQuote, isResponse: audioObj!.isResponse)
            
            favoritesOutlet.selected = true
            // Array is inserted
            viewController?.mutateFavorites(newObj)
            
        }
        else {
            defaults.setBool(false, forKey: titleLabel.text!)
            //println("Favorites set to  \(defaults.boolForKey(titleLabel.text!)) for  \(titleLabel.text!)")
            viewController?.removeFromFavorites(titleLabel.text!)
            favoritesOutlet.selected = false
        }

    }
    
    @IBAction func playSound(sender: UIButton) {
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
    
}
