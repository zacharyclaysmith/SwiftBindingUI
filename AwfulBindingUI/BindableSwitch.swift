//
//  File.swift
//  AwfulBindingUI
//
//  Created by Zachary Smith on 2/27/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//

import Foundation
import UIKit
import AwfulBinding

public class BindableSwitch:UISwitch{
    private var _bindableValue:BindableValue<Bool>?
    
    public var bindableValue:BindableValue<Bool>?{
        get{
            return _bindableValue
        }
        
        set(newValue){
            _bindableValue?.removeListener(self)
            
            _bindableValue = newValue
            
            _bindableValue?.addListener(self, listener:valueChanged, alertNow: true)
        }
    }
    
    override init() {
        super.init()
        
        self.addTarget(self, action: "switchChanged", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addTarget(self, action: "switchChanged", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.addTarget(self, action: "switchChanged", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    private func valueChanged(newValue:Bool){
        if(_bindableValue != nil && _bindableValue!.value != self.on){
            self.on = newValue
        }
    }
    
    public func switchChanged(){
        if(_bindableValue != nil && _bindableValue!.value != self.on){
            _bindableValue!.value = self.on
        }
    }
    
    deinit{
        _bindableValue?.removeListener(self)
    }
}