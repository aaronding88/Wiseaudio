//
//  SecondViewController.swift
//  TheRoomAudiotexts
//
//  Created by Aaron Ding on 5/10/15.
//  Copyright (c) 2015 Aaron Ding. All rights reserved.
//

import UIKit
import AVFoundation

// Response portion of the app
class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate
{
    
    //TODO: implement searchBarSearchButtonClicked
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var soundList : AudioList!
    
    @IBOutlet weak var viewController: UICollectionView!
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        // Function already searched via searchBar, so all we have to do is relinquish first-responder.
        searchBar.resignFirstResponder()
    }
    
    // Main Search function, allowing users to search using input.
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // searchAudio should clear current loadedArray, then populate the list with searched text.
        soundList.searchAudio(searchText)
        
        // Refreshes the list so items display.
        viewController.reloadData()
    }
    
    // Tab function, containing the different filters.
    func reloadLoadedArrays() {
        switch segmentedControl.selectedSegmentIndex
        {
            // Clears the loaded array in case it's populated. Then populates based off of the imageIcon filename.
        case 0: // All
            soundList.clearLoadedArray()
            soundList.loadResponseArrayExceptions()
        case 1: // Johnny
            soundList.clearLoadedArray()
            soundList.loadResponseArray(segmentedControl.titleForSegmentAtIndex(1)!)
        case 2: // Lisa
            soundList.clearLoadedArray()
            soundList.loadResponseArray(segmentedControl.titleForSegmentAtIndex(2)!)
        case 3: // Mark
            soundList.clearLoadedArray()
            soundList.loadResponseArray(segmentedControl.titleForSegmentAtIndex(3)!)
        case 4: // Denny
            soundList.clearLoadedArray()
            soundList.loadResponseArray(segmentedControl.titleForSegmentAtIndex(4)!)
        case 5: // Others
            soundList.clearLoadedArray()
            soundList.loadResponseArray(segmentedControl.titleForSegmentAtIndex(5)!)
        default:
            soundList.clearLoadedArray()
            soundList.loadResponseArrayExceptions()
            println("Segmented controls: Default was loaded")
        }
        viewController.reloadData()
    }
    // Upon touching a part of the View, resign all first responders. Note that touching the UICollectionView
    // does not fall under this method.
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    // Called via setNeedsStatusBarAppearanceUpdate, and returns the LightContent value of the status bar.
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // Occurs everytime this view is loaded.
    override func viewWillAppear(animated: Bool) {
        // Reloads the data, so any changes that have happened in the other displays will be reflected here.
        reloadLoadedArrays()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        soundList = appDelegate.getAudioList()
        // Do any additional setup after loading the view, typically from a nib.
        self.setNeedsStatusBarAppearanceUpdate()
        soundList.clearLoadedArray()
        soundList.loadResponseArrayExceptions()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // If the segmented controls change, adjust the loaded arrays.se
    @IBAction func Category(sender: UISegmentedControl) {
        reloadLoadedArrays()
    }
    internal func mutateFavorites(newObj: AudioObject) {
        soundList.setFavArray(newObj)
    }

    // Required method. Returns the amount of items in a section.
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return soundList.getAudioLength()
    }
    // Required method. Called for each cell that exists, and instantiates the data inside.
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // cell dequeues any pre-existing cell and populates it with new information, if necessary.
        let cell: CollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        // Cell will initialize all the properties. 
        cell.initialize(soundList.loadedArray[indexPath.row], viewController: self)
        
        // Returns the cell.
        return cell
    }
    
}

