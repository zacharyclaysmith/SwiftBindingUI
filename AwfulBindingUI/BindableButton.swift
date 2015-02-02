//
//  BindableButton.swift
//  ARWorld
//
//  Created by Zachary Smith on 12/22/14.
//  Copyright (c) 2014 Scal.io. All rights reserved.
//

import Foundation
import UIKit
import AwfulBinding

public class BindableButton:UIButton{
    private var _enabledBinding:BindableValue<Bool>?
    
    public var enabledBinding:BindableValue<Bool>?{
        get{
            return _enabledBinding
        }
        
        set(newValue){
            _enabledBinding = newValue
            
            _enabledBinding?.addListener(self, listener:valueChanged, alertNow: true)
        }
    }
    
    private func valueChanged(newValue:Bool?){
        self.enabled = newValue != nil ? newValue! : false
    }
}