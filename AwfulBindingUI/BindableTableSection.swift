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
    public var data:PBindableCollection?
    
    public init(data:PBindableCollection? = nil){
        self.data = data
    }
    
    public init(data:PBindableCollection?, headerText:String?){
        self.headerText = headerText
        self.data = data
    }
    
    public init(data:PBindableCollection?, headerViewCreator:(() -> UIView)?){
        self.headerViewCreator = headerViewCreator
        self.data = data
    }
}