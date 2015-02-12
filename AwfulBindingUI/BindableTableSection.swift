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
    
    public init(headerText:String? = nil, headerViewCreator:(() -> UIView)? = nil, data:PBindableCollection? = nil){
        self.headerText = headerText
        self.headerViewCreator = headerViewCreator
        self.data = data
    }
}