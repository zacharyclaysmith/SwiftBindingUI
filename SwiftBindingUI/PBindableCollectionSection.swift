//
//  PBindableCollectionSection.swift
//  SwiftBindingUI
//
//  Created by Zachary Smith on 2/22/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//

import Foundation
import SwiftBinding

public protocol PBindableCollectionSection{
    var headerText:String? {get set}
    var headerViewCreator:(() -> UIView)? {get set}
    var collectionData:PBindableCollection! {get}
    
    var createCell:((index:Int, indexPath:NSIndexPath) -> UICollectionViewCell)? {get set}
    var onSelect:((index:Int) -> Void)? {get set}
}