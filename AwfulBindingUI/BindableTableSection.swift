//
//  BindableSection.swift
//  AwfulBindingUI
//
//  Created by Zachary Smith on 2/12/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//

import Foundation
import AwfulBinding

public class BindableTableSection{
    public var headerText:String?
    public var headerViewCreator:(() -> UIView)?
    public var data:PBindableCollection!
    
    public var createCell:((index:Int) -> UITableViewCell)?
    
    public init(data:PBindableCollection, createCell:((index:Int) -> UITableViewCell)? = nil){
        self.data = data
        self.createCell = createCell
    }
    
    public convenience init(data:PBindableCollection, headerText:String?, createCell:((index:Int) -> UITableViewCell)? = nil){
        self.init(data:data, createCell:createCell)
        
        self.headerText = headerText
    }
    
    public convenience init(data:PBindableCollection, headerViewCreator:(() -> UIView)?, createCell:((index:Int) -> UITableViewCell)? = nil){
        self.init(data:data, createCell:createCell)
        
        self.headerViewCreator = headerViewCreator
    }
}