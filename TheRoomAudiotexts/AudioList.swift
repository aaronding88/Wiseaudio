//
//  AudioList.swift
//  TheRoomAudiotexts
//
//  Created by Aaron Ding on 5/12/15.
//  Copyright (c) 2015 Aaron Ding. All rights reserved.
//

import UIKit

//TODO: Clean up AudioList, it looks ugly as tits.
class AudioList {
    
    let categories = ["Friendly", "Positive", "Upset", "Negative", "Neutral"]
    
    // Image file type.
    let fileType : String = "png"
    
    // The three arrays stored within this Model. One stores long term audio, one stores favorite, and one stores currently visible elements.
    var audioArray = [AudioObject]()
    var favoritesArray = [AudioObject]()
    var loadedArray = [AudioObject]()
    
    // Instantiates the audio, and appends them to the longterm array.
    func loadAudio(titleText: String, descriptionText: String, fileNameText: String, imgNameText: String, isQuote: Bool, isResponse: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // Temp audio creates an audio object with the properties passed in, and then appends it to the array.
        var tempAudio = AudioObject(title: titleText, audioDescription: descriptionText, fileName: fileNameText, imgName: imgNameText, favorite: defaults.boolForKey(titleText), isQuote: isQuote, isResponse: isResponse)
        if (defaults.boolForKey(titleText)) {
            favoritesArray.append(tempAudio)
        }
        audioArray.append(tempAudio)
    }

    // Overloaded function of loadAudio which contains category.
    func loadAudio(titleText: String, descriptionText: String, fileNameText: String, imgNameText: String, isQuote: Bool, isResponse: Bool, category: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // Temp audio creates an audio object with the properties passed in, and then appends it to the array.
        var tempAudio = AudioObject(title: titleText, audioDescription: descriptionText, fileName: fileNameText, imgName: imgNameText, favorite: defaults.boolForKey(titleText), isQuote: isQuote, isResponse: isResponse, category: category)
        if (defaults.boolForKey(titleText)) {
            favoritesArray.append(tempAudio)
        }
        audioArray.append(tempAudio)
    }
    
    // Search function that will load audios to the loadAudio array.
    func searchAudio(searchBarText: String) {
        // Clears the array.
        clearLoadedArray()
        
        // Use searchBarText string to parse through the audioArray, checking the items to see if the strings match the items.
        for (var i : Int = 0; i < audioArray.count; i++) {
            var match : Bool = false
            // Downcasts both strings to lower case, so both aren't case sensitive.
            if audioArray[i].title.lowercaseString.rangeOfString(searchBarText.lowercaseString) != nil {
                match = true
            }
            else if audioArray[i].audioDescription.lowercaseString.rangeOfString(searchBarText.lowercaseString) != nil {
                match = true
            }
            else if audioArray[i].fileName.lowercaseString.rangeOfString(searchBarText.lowercaseString) != nil {
                match = true
            }
            
            // If a match was made earlier, add this array to the Loaded Array.
            if (match) {
                loadedArray.append(audioArray[i])
            }
        }
    }
    // By default, init will find audio files and append them to the Audio Array.
    init() {
        // TODO: Add more quotes, edit current ones.
        // By loading the strings into these categories, if any category changes strings, we won't have to edit the strings down this entire section.
        let friendly : String = categories[0], positive = categories[1], upset = categories[2], negative = categories[3], neutral = categories[4]
        
        // Load Denny Elements
        loadAudio("Don't gang up on me!", descriptionText: "\"Stop ganging up on me!\"", fileNameText: "Denny_GangingUp", imgNameText: "DennyIcon.\(fileType)", isQuote: false, isResponse: true, category: upset)
        loadAudio("Denny speaks truth.", descriptionText: "\"You're not my fucking mother!\"", fileNameText: "Denny_NotMyMother", imgNameText: "DennyIcon.\(fileType)", isQuote: false, isResponse: true, category: upset)
        loadAudio("Voyeur Denny!", descriptionText: "\"I just like to watch you guys.\"", fileNameText: "Denny_WatchYouGuys", imgNameText: "DennyIcon.\(fileType)", isQuote: true, isResponse: true, category: neutral)
        
        // Load Friend Elements
        loadAudio("Florist's low standards.", descriptionText: "\"You're my favorite customer.\"", fileNameText: "Florist_FavoriteCustomer", imgNameText: "FloristIcon.\(fileType)", isQuote: true, isResponse: true, category: friendly)
        loadAudio("Like a poet.", descriptionText: "\"Did you know that chocolate is the symbol of love?\"", fileNameText: "Friend01_ChocolateSymbolism", imgNameText: "Friend01Icon.\(fileType)", isQuote: true, isResponse: false)
        loadAudio("A grown up date", descriptionText: "\"I gotta go see Michelle in a little bit to make out with her.\"", fileNameText: "Friend01_MakeOut", imgNameText: "Friend01Icon.\(fileType)", isQuote: true, isResponse: false)
        loadAudio("An Atomic Simile", descriptionText: "\"I feel like I'm sitting on an atomic bomb waiting for it to go off.\"", fileNameText: "Friend02_AtomicSimile", imgNameText: "Friend02Icon.\(fileType)", isQuote: true, isResponse: true, category: upset)
        loadAudio("Chris R. is in a hurry.", descriptionText: "\"Five minutes? You want five fucking minutes Denny? You know what? I haven't got FIVE FUCKING MINUTES!\"", fileNameText: "ChrisR_InAHurry", imgNameText: "ChrisRIcon.\(fileType)", isQuote: true, isResponse: false)
        loadAudio("Chris R: Rooftop Hustler.", descriptionText: "\"WHERE'S MY FUCKING MONEY DENNY?!\"", fileNameText: "ChrisR_WheresMyMoney", imgNameText: "ChrisRIcon.\(fileType)", isQuote: true, isResponse: false)
        loadAudio("Casual Breast Cancer", descriptionText: "\"I got the results of the test back, I definitely have breast cancer.\"", fileNameText: "Claudette_BreastCancer", imgNameText: "ClaudetteIcon.\(fileType)", isQuote: true, isResponse: false)
        loadAudio("Marriage Counseling.", descriptionText: "\"Marriage has nothing to do with love.\"", fileNameText: "Claudette_MarriageAdvice", imgNameText: "ClaudetteIcon.\(fileType)", isQuote: true, isResponse: false)
        
        // Load Johnny Elements
        loadAudio("Anything, Johnny?", descriptionText: "\"I would do anything for my girl.\"", fileNameText: "Johnny_AnythingForLisa", imgNameText: "JohnnyIcon.\(fileType)", isQuote: false, isResponse: true, category: positive)
        loadAudio("Lisa is a secret Princess.", descriptionText: "\"Anything for my Princeeeess haha.\"", fileNameText: "Johnny_AnythingForMyPrincess", imgNameText: "JohnnyIcon.\(fileType)", isQuote: true, isResponse: true, category: positive)
        loadAudio("Betrayed by the Bank.", descriptionText: "\"They betray me, they didn't keep their promise, they tricked me, and I don't care anymore.\"", fileNameText: "Johnny_BankBetrayed", imgNameText: "JohnnyIcon.\(fileType)", isQuote: true, isResponse: true, category: upset)
        loadAudio("Everyone's cheeping.", descriptionText: "\"Cheep cheep cheep cheep cheep cheep cheep cheep cookoo!\"", fileNameText: "Johnny_Cheep01", imgNameText: "JohnnyIcon.\(fileType)", isQuote: true, isResponse: true, category: negative)
        loadAudio("Chicken impression.", descriptionText: "\"Cheep, cheep cheep cheep cheep cheep, cheeeuhhuhhuhhh.\"", fileNameText: "Johnny_Cheep02", imgNameText: "JohnnyIcon.\(fileType)", isQuote: true, isResponse: true, category: negative)
        loadAudio("Johnny's legendary taunt.", descriptionText: "\"You betrayed me you not good, you just a chicken cheep cheep cheep.\"", fileNameText: "Johnny_Cheep03", imgNameText: "JohnnyIcon.\(fileType)", isQuote: true, isResponse: true, category: upset)
        loadAudio("Don't talk like that.", descriptionText: "\"How dare you talk to me like that?\"", fileNameText: "Johnny_DontTalkLikeThat", imgNameText: "JohnnyIcon.\(fileType)", isQuote: false, isResponse: true, category: upset)
        loadAudio("Don't touch him.", descriptionText: "\"Don't touch me mother fucker.\"", fileNameText: "Johnny_DontTouchMe", imgNameText: "JohnnyIcon.\(fileType)", isQuote: true, isResponse: true, category: upset)
        loadAudio("Johnny addresses the world.", descriptionText: "\"I'm fed up with this, world.\"", fileNameText: "Johnny_FedUp", imgNameText: "JohnnyIcon.\(fileType)", isQuote: true, isResponse: true, category: upset)
        loadAudio("Johnny can't fathom evil.", descriptionText: "\"How can they say this about me? I don't believe it.\"", fileNameText: "Johnny_FriendBetrayed", imgNameText: "JohnnyIcon.\(fileType)", isQuote: false, isResponse: true, category: negative)
        loadAudio("Lisa has foresight.", descriptionText: "\"Thank you honey, this is a beautiful party. You invited all my friends, good thinking!\"", fileNameText: "Johnny_GoodThinking", imgNameText: "JohnnyIcon.\(fileType)", isQuote: true, isResponse: false)
        loadAudio("Johnny's famous laugh.", descriptionText: "\"Tsa ha ha.\"", fileNameText: "Johnny_Haha", imgNameText: "JohnnyIcon.\(fileType)", isQuote: true, isResponse: true, category: friendly)
        loadAudio("Rub it in, Johnny.", descriptionText: "\"I'm so happy I have you as my best friend, and I love Lisa so much.\"", fileNameText: "Johnny_HappyWithLife", imgNameText: "JohnnyIcon.\(fileType)", isQuote: true, isResponse: false)
        loadAudio("Not so happy to see Denny.", descriptionText: "\"Oh hi Dny.\"", fileNameText: "Johnny_HiDenny", imgNameText: "JohnnyIcon.\(fileType)", isQuote: true, isResponse: false)
        loadAudio("Whoa there's a dog here.", descriptionText: "\"Hi Doggy!\"", fileNameText: "Johnny_HiDoggy", imgNameText: "JohnnyIcon.\(fileType)", isQuote: false, isResponse: true, category: friendly)
        loadAudio("Convincingly didn't hit her.", descriptionText: "\"I did not hit her, it's not true, it's bullshit, I did not hit her, I did naaht.\"", fileNameText: "Johnny_IDidNaht", imgNameText: "JohnnyIcon.\(fileType)", isQuote: true, isResponse: false)
        loadAudio("Johnny wants us to eat.", descriptionText: "\"Let's go eat, haea.\"", fileNameText: "Johnny_LetsGoEat", imgNameText: "JohnnyIcon.\(fileType)", isQuote: false, isResponse: true, category: friendly)
        loadAudio("Grateful Johnny.", descriptionText: "\"You think about everything, haha.\"", fileNameText: "Johnny_LisaIsThoughtful", imgNameText: "JohnnyIcon.\(fileType)", isQuote: false, isResponse: true, category: friendly)
        loadAudio("Talking about Women, sadly.", descriptionText: "\"Just talking about women *Sad music*.\"", fileNameText: "Johnny_SadAboutWomen", imgNameText: "JohnnyIcon.\(fileType)", isQuote: false, isResponse: true, category: negative)
        loadAudio("Perfect icebreaker.", descriptionText: "\"I cannot tell you it's confidential.\" \"Oh come on, why not?\" \"No, I can't. Anyway how's your sex life?\"", fileNameText: "Johnny_SexLife", imgNameText: "JohnnyIcon.\(fileType)", isQuote: true, isResponse: false)
        loadAudio("Johnny disses your mom.", descriptionText: "\"You and your stupid mother.\"", fileNameText: "Johnny_StupidMother", imgNameText: "JohnnyIcon.\(fileType)", isQuote: false, isResponse: true, category: upset)
        loadAudio("A declaration of napping.", descriptionText: "\"I'm going to take a nap.\"", fileNameText: "Johnny_TakeANap", imgNameText: "JohnnyIcon.\(fileType)", isQuote: false, isResponse: true, category: neutral)
        loadAudio("Vodka Scotch tastes good.", descriptionText: "\"Mmm you're right it tastes good, haha\"", fileNameText: "Johnny_TastesGood", imgNameText: "JohnnyIcon.\(fileType)", isQuote: false, isResponse: true, category: positive)
        loadAudio("Everything, Lisa. Everything.", descriptionText: "\"You should tell me everything!\"", fileNameText: "Johnny_TellMeEverything", imgNameText: "JohnnyIcon.\(fileType)", isQuote: false, isResponse: true, category: upset)
        loadAudio("Here's Johnny!", descriptionText: "\"Thats me!\"", fileNameText: "Johnny_ThatsMe", imgNameText: "JohnnyIcon.\(fileType)", isQuote: false, isResponse: true, category: friendly)
        loadAudio("Tired, Wasted, and in love.", descriptionText: "\"I'm tired, I'm wasted, I love you darling.\"", fileNameText: "Johnny_TiredWastedInLove", imgNameText: "JohnnyIcon.\(fileType)", isQuote: true, isResponse: true, category: friendly)
        loadAudio("Not into threesomes.", descriptionText: "\"Two's great but three's a crowd, hehe.\"", fileNameText: "Johnny_TwoIsGreat", imgNameText: "JohnnyIcon.\(fileType)", isQuote: false, isResponse: true, category: friendly)
        loadAudio("Expectant father.", descriptionText: "\"Hey everybody! I have an announcement to make. We are expecting!\"", fileNameText: "Johnny_WeAreExpecting", imgNameText: "JohnnyIcon.\(fileType)", isQuote: true, isResponse: false)
        loadAudio("What a story!", descriptionText: "\"Hahaha. What a story Mark!\"", fileNameText: "Johnny_WhatAStory", imgNameText: "JohnnyIcon.\(fileType)", isQuote: true, isResponse: true, category: positive)
        loadAudio("Not pleased.", descriptionText: "\"Well, whatever.\"", fileNameText: "Johnny_Whatever", imgNameText: "JohnnyIcon.\(fileType)", isQuote: false, isResponse: true, category: negative)
        loadAudio("Why Denny?!.", descriptionText: "\"Why did you do this? You know better right? WHY?\"", fileNameText: "Johnny_WhyDenny", imgNameText: "JohnnyIcon.\(fileType)", isQuote: true, isResponse: true, category: upset)
        
        // Load Lisa Elements
        loadAudio("Detective Lisa 1.", descriptionText: "\"Did you get your promotion?\" \"No\" \"You didn't get it did you?\"", fileNameText: "Lisa_DetectiveLisa1", imgNameText: "LisaIcon.\(fileType)", isQuote: true, isResponse: false)
        loadAudio("Detective Lisa 2.", descriptionText: "\"Is he dead?\"", fileNameText: "Lisa_DetectiveLisa2", imgNameText: "LisaIcon.\(fileType)", isQuote: true, isResponse: false)
        loadAudio("Lisa's drug curiosity.", descriptionText: "\"What kind of drugs do you take?!\"", fileNameText: "Lisa_DrugCuriosity", imgNameText: "LisaIcon.\(fileType)", isQuote: true, isResponse: true, category: upset)
        loadAudio("Lisa the seductress.", descriptionText: "\"I like you very much, lover boy.\"", fileNameText: "Lisa_LoverBoy", imgNameText: "LisaIcon.\(fileType)", isQuote: true, isResponse: true, category: positive)
        loadAudio("That escalated quickly", descriptionText: "\"She's a stupid bitch.\"", fileNameText: "Lisa_StupidBitch", imgNameText: "LisaIcon.\(fileType)", isQuote: false, isResponse: true, category: negative)
        loadAudio("Lisa has foresight.", descriptionText: "\"Do you want me to order a pizza?\" \"Whatever I don't care.\" \"I already ordered a pizza.\"", fileNameText: "Lisa_ThinksOfEverything", imgNameText: "LisaIcon.\(fileType)", isQuote: true, isResponse: false)
        loadAudio("Doubloons?! Pesos?! Kips?", descriptionText: "\"What kind of money?!\"", fileNameText: "Lisa_WhatKindMoney", imgNameText: "LisaIcon.\(fileType)", isQuote: true, isResponse: true, category: negative)
        loadAudio("Lisa is concerned.", descriptionText: "\"WHAT THE HELL IS WRONG WITH YOU?!\"", fileNameText: "Lisa_Concerned", imgNameText: "LisaIcon.\(fileType)", isQuote: true, isResponse: true, category: upset)
        loadAudio("Stability is boring.", descriptionText: "\"And he told me he plans to buy you a house!\" \"That's why he's so boring.\"", fileNameText: "Lisa_WhyHesBoring", imgNameText: "LisaIcon.\(fileType)", isQuote: true, isResponse: false)
        // Load Mark Elements
        loadAudio("Mark's handsome entrance.", descriptionText: "\"Whoaa!! Hey guys.\"", fileNameText: "Mark_HandsomeEntrance", imgNameText: "MarkIcon.\(fileType)", isQuote: false, isResponse: true, category: positive)
        loadAudio("Mark is indecisive.", descriptionText: "\"Oh hey how you doing, yeah I'm very busy, what's going on?\"", fileNameText: "Mark_Indecisive", imgNameText: "MarkIcon.\(fileType)", isQuote: true, isResponse: true, category: friendly)
        loadAudio("Stupid pocket comments.", descriptionText: "\"Leave your stupid comments in your pocket.\"", fileNameText: "Mark_StupidComments", imgNameText: "MarkIcon.\(fileType)", isQuote: true, isResponse: true, category: upset)
        loadAudio("Mark wants your body", descriptionText: "\"I want your body.\"", fileNameText: "Mark_WantsYourBody", imgNameText: "MarkIcon.\(fileType)", isQuote: false, isResponse: true, category: positive)
        
    }
    
    // Returns the loaded audio's total length.
    internal func getAudioLength() -> Int{
        return loadedArray.count
    }
    // Returns an Int to see how many favorites are in the Array.
    //#WARNING: Inconsistent naming. It should be similar to the previous method.
    internal func numberOfFavorites() -> Int {
        return favoritesArray.count
    }

    // Adds an element in the favorite arrays.
    internal func setFavArray(audioObj: AudioObject)
    {
        favoritesArray.insert(audioObj, atIndex: 0)
        println("inserted \(audioObj.title) into the favorites. Array now has \(favoritesArray.count)")
    }

    // Clears the loadedArray, and the capacity is reset as well.
    internal func clearLoadedArray() {
        loadedArray.removeAll(keepCapacity: false)
    }

    // Adds elements to the loaded array, which will let the "category" filter out items. NOT a user search method.
    internal func loadResponseArray(characterCategory: String) {
        var loadIndex : Int = 0
        
        // Parses through the array, checks to see if the element's image name is the same as the String.
        for (var i : Int = 0; i < audioArray.count; i++){
            if audioArray[i].category == characterCategory && audioArray[i].isResponse {
                loadedArray.append(audioArray[i])
                loadIndex++
            }
        }
        println("Loaded Array has \(loadedArray.count) elements of responses.")
    }

    // Any exceptional loading arrays will be done here.
    //#WARNING: THIS IS BAD PRACTICE, but works for the purposes of the app!!
    internal func loadResponseArrayExceptions() {
        for (var i : Int = 0; i < audioArray.count; i++){
            if audioArray[i].isResponse {
                loadedArray.append(audioArray[i])
            }
        }
        println("Loaded Array has \(loadedArray.count) elements.")
    }
    
    // Adds elements to the loaded array, which will let the "category" filter out items. NOT a user search method.
    internal func loadQuotesArray(characterCategory: String) {
        var loadIndex : Int = 0
        
        // Parses through the array, checks to see if the element's image name is the same as the String.
        for (var i : Int = 0; i < audioArray.count; i++){
            if audioArray[i].imgName == characterCategory && audioArray[i].isQuote {
                loadedArray.append(audioArray[i])
                loadIndex++
            }
        }
        println("Loaded Array has \(loadedArray.count) elements of responses.")
    }
    
    // Any exceptional loading arrays will be done here.
    //#WARNING: THIS IS BAD PRACTICE, but works for the purposes of the app!!
    internal func loadQuotesArrayExceptions(isAll : Bool) {
        // If it's loading all, do this.
        if isAll {
            for (var i : Int = 0; i < audioArray.count; i++){
                if audioArray[i].isQuote {
                    loadedArray.append(audioArray[i])
                }
            }
            println("Loaded Array has \(loadedArray.count) elements.")
        }
            // Loads files that's none of the 4 segments.
        else {
            for (var i : Int = 0; i < audioArray.count; i++){
                if (audioArray[i].imgName != "JohnnyIcon.\(fileType)"
                    && audioArray[i].imgName != "MarkIcon.\(fileType)"
                    && audioArray[i].imgName != "LisaIcon.\(fileType)"
                    && audioArray[i].imgName != "DennyIcon.\(fileType)"
                    && audioArray[i].isQuote){
                        loadedArray.append(audioArray[i])
                }
            }
            println("Loaded Array has \(loadedArray.count) elements.")
        }
    }

    // Adds an element in the favorite arrays.
    internal func removeFavArray(titleLabelText: String)
    {
        var found : Bool = false
        for (var i : Int = 0; i < favoritesArray.count && !found; i++){
            if (favoritesArray[i].title == titleLabelText){
                favoritesArray.removeAtIndex(i)
                found = true
                println("Found it! Removed \(titleLabelText). Array now has \(favoritesArray.count) elements.")
            }
        }
        if (!found) {
            println("Did not find the element \(titleLabelText)")
        }
    }
}