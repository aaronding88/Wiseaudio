//
//  AudioObject.swift
//  TheRoomAudiotexts
//
//  Audio object is a simple struct object that stores various string information.
//
//  Created by Aaron Ding on 5/11/15.
//  Copyright (c) 2015 Aaron Ding. All rights reserved.
//

import UIKit

class AudioObject {
    var title : String
    var audioDescription : String
    var fileName : String
    var imgName : String
    var favorite : Bool
    var isQuote : Bool
    var isResponse : Bool
    var category : String
    
    
    // Default initiation.
    init() {
        self.title = "Default title"
        self.audioDescription = "Default Description"
        self.fileName = "Cheep_01-AIFF"
        self.imgName = "tommy_wiseau.jpg"
        self.favorite = false
        isQuote = true
        isResponse = true
        category = "null"
    }
    
    // Initialize without a category description.
    init(title: String, audioDescription: String, fileName: String, imgName: String, favorite: Bool, isQuote : Bool, isResponse : Bool) {
        self.title = title
        self.audioDescription = audioDescription
        self.fileName = fileName
        self.imgName = imgName
        self.favorite = favorite
        self.isQuote = isQuote
        self.isResponse = isResponse
        self.category = "null"
    }
    
    // Initialize with a category description.
    init(title: String, audioDescription: String, fileName: String, imgName: String, favorite: Bool, isQuote : Bool, isResponse : Bool, category : String) {
        self.title = title
        self.audioDescription = audioDescription
        self.fileName = fileName
        self.imgName = imgName
        self.favorite = favorite
        self.isQuote = isQuote
        self.isResponse = isResponse
        self.category = category
    }
}