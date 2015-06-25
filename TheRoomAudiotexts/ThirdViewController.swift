//
//  ThirdViewController.swift
//  Wiseaudio
//
//  Created by Aaron Ding on 5/26/15.
//  Copyright (c) 2015 Aaron Ding. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var soundList : AudioList!
    
    func reloadLoadedArrays() {
        switch segmentedControl.selectedSegmentIndex
        {
            // Clears the loaded array in case it's populated. Then populates based off of the imageIcon filename.
        case 0: // All
            searchBar.text = ""
            soundList.clearLoadedArray()
            soundList.loadQuotesArrayExceptions(true)
        case 1: // Johnny
            searchBar.text = ""
            soundList.clearLoadedArray()
            soundList.loadQuotesArray("JohnnyIcon.png")
        case 2: // Lisa
            searchBar.text = ""
            soundList.clearLoadedArray()
            soundList.loadQuotesArray("LisaIcon.png")
        case 3: // Mark
            searchBar.text = ""
            soundList.clearLoadedArray()
            soundList.loadQuotesArray("MarkIcon.png")
        case 4: // Denny
            searchBar.text = ""
            soundList.clearLoadedArray()
            soundList.loadQuotesArray("DennyIcon.png")
        case 5: // Others
            searchBar.text = ""
            soundList.clearLoadedArray()
            soundList.loadQuotesArrayExceptions(false)
        default:
            soundList.clearLoadedArray()
            soundList.loadQuotesArrayExceptions(true)
            println("Segmented controls: Default was loaded")
        }
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        // Function already searched via searchBar, so all we have to do is relinquish first-responder.
        searchBar.resignFirstResponder()
    }
    
    // Main Search function, allowing users to search using input.
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // searchAudio should clear current loadedArray, then populate the list with searched text.
        soundList.searchAudio(searchText)
        
        // Refreshes the list so items display.
        collectionView.reloadData()
    }
    
    // Since the background is a darker color, return light frame.
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // Occurs everytime this view is loaded, before it actually loads.
    override func viewWillAppear(animated: Bool) {
        // Internal function
        reloadLoadedArrays()
    }
    
    internal func mutateFavorites(newObj: AudioObject) {
        soundList.setFavArray(newObj)
    }
    internal func removeFromFavorites(titleLabel: String) {
        soundList.removeFavArray(titleLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        soundList = appDelegate.getAudioList()
        // Do any additional setup after loading the view.
        self.setNeedsStatusBarAppearanceUpdate()
        
        // Clears the loaded array, and adds all the audio.
        soundList.clearLoadedArray()
        soundList.loadQuotesArrayExceptions(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Category(sender: UISegmentedControl) {
        reloadLoadedArrays()
    }
        // Required method: returns the number of views that should exist.
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return soundList.getAudioLength()
    }
    
        // Required method: populates the cells with information.
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: QuotesCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("quotesCollectionVC", forIndexPath: indexPath) as! QuotesCollectionViewCell

         cell.initialize(soundList.loadedArray[indexPath.row], viewController: self)
        
        return cell
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
