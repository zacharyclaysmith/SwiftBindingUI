//
//  PTextBindable.swift
//  SwiftBindingUI
//
//  Created by Zachary Smith on 3/27/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//

import Foundation
import SwiftBinding

public protocol PTextBindable{
    var textBinding:BindableValue<String>? {get set}
}