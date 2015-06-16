//
//  FirstViewController.swift
//  TheRoomAudiotexts
//
//  Created by Aaron Ding on 5/10/15.
//  Copyright (c) 2015 Aaron Ding. All rights reserved.
//

import UIKit

/*
 * First View Controller will handle the View of the Favorites section.
 * Requirements: References to UICollectionView.
 */
class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var soundList : AudioList!
    
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    @IBOutlet weak var favoritesLabel: UILabel!

    override func viewWillAppear(animated: Bool) {
        favoriteCollectionView.reloadData()
        if soundList.numberOfFavorites() == 0 {
            favoritesLabel.hidden = false
        } else {
            favoritesLabel.hidden = true
        }
    }
    
    // Called via setNeedsStatusBarAppearanceUpdate, and returns the LightContent value of the status bar.
    //#Question: May need to put this in the AppDelegate, or at least some overarching initializer. 
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setNeedsStatusBarAppearanceUpdate()
        soundList = appDelegate.getAudioList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    internal func removeFromFavorites(title: String) {
        soundList.removeFavArray(title)
    }
    
    // Required method. Returns the amount of items in a section.
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        println("Sound List returned \(soundList.numberOfFavorites())")
        return soundList.numberOfFavorites()
    }
    // Required method. Called for each cell that exists, and instantiates the data inside.
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // cell dequeues any pre-existing cell and populates it with new information, if necessary.
        let cell: FavoriteViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("FavoriteViewCell", forIndexPath: indexPath) as! FavoriteViewCell
        
        // Cell will initialize all the properties.
        cell.initialize(soundList.favoritesArray[indexPath.row], viewController: self)
        
        // Returns the cell.
        return cell
    }


}

