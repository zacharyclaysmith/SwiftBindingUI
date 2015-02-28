//
//  PBindableTextSection.swift
//  AwfulBindingUI
//
//  Created by Zachary Smith on 2/22/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//

import Foundation
import AwfulBinding

public protocol PBindableTableSection{
    var headerText:String? {get set}
    var headerViewCreator:(() -> UIView)? {get set}
    var tableData:PBindableCollection! {get}
    
    var createCell:((index:Int) -> UITableViewCell)? {get set}
    var onSelect:((index:Int) -> Void)? {get set}
}