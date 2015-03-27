//
//  PTextBindable.swift
//  AwfulBindingUI
//
//  Created by Zachary Smith on 3/27/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//

import Foundation
import AwfulBinding

public protocol PTextBindable{
    var textBinding:BindableValue<String>? {get set}
}