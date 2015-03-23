//
//  BindableView.swift
//  AwfulBindingUI
//
//  Created by Zachary Smith on 3/5/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//

import Foundation
import UIKit
import AwfulBinding

public class BindableView:UIView{
    private var _hiddenBinding:BindableValue<Bool>?
    
    public var hiddenBinding:BindableValue<Bool>?{
        get{
            return _hiddenBinding
        }
        
        set(newValue){
            _hiddenBinding?.removeListener(self)
            
            _hiddenBinding = newValue
            
            _hiddenBinding?.addListener(self, listener:valueChanged, alertNow: true)
        }
    }
    
    deinit{
        _hiddenBinding?.removeListener(self)
    }
    
    private func valueChanged(newValue:Bool){
        self.hidden = newValue
    }
}