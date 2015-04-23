//
//  BindableView.swift
//  SwiftBindingUI
//
//  Created by Zachary Smith on 3/5/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//

import Foundation
import UIKit
import SwiftBinding

public class BindableView:UIView, PHiddenBindable{
    private var _hiddenBinding:BindableValue<Bool>?
    
    public var hiddenBinding:BindableValue<Bool>?{
        get{
            return _hiddenBinding
        }
        
        set(newValue){
            _hiddenBinding?.removeListener(self)
            
            _hiddenBinding = newValue
            
            _hiddenBinding?.addListener(self, alertNow: true, listener:hiddenBinding_valueChanged)
        }
    }
    
    deinit{
        _hiddenBinding?.removeListener(self)
    }
    
    private func hiddenBinding_valueChanged(newValue:Bool){
        self.hidden = newValue
    }
}