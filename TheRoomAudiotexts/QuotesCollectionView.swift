//
//  QuotesCollectionView.swift
//  Wiseaudio
//
//  Created by Aaron Ding on 6/24/15.
//  Copyright (c) 2015 Aaron Ding. All rights reserved.
//

import UIKit

class QuotesCollectionView: UICollectionView {
    
    // Activates when the user touches the collectionview.
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if self.superview != nil {
            self.superview?.endEditing(true)
        }
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
