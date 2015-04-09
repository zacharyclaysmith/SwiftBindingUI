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

public class BindableSwitch:UISwitch, PHiddenBindable{
    private var _onBinding:BindableValue<Bool>?
    
    //DEPRECATED
    public var bindableValue:BindableValue<Bool>?{
        get{
            return _onBinding
        }
        
        set(newValue){
            _onBinding?.removeListener(self)
            
            _onBinding = newValue
            
            _onBinding?.addListener(self, alertNow: true, listener:valueChanged)
        }
    }
    
    public var onBinding:BindableValue<Bool>?{
        get{
            return _onBinding
        }
        
        set(newValue){
            _onBinding?.removeListener(self)
            
            _onBinding = newValue
            
            _onBinding?.addListener(self, alertNow: true, listener:valueChanged)
        }
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
        if(_onBinding != nil && _onBinding!.value != self.on){
            self.on = newValue
        }
    }
    
    public func switchChanged(){
        if(_onBinding != nil && _onBinding!.value != self.on){
            _onBinding!.value = self.on
        }
    }
    
    deinit{
        _onBinding?.removeListener(self)
        _hiddenBinding?.removeListener(self)
    }
    
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
    
    private func hiddenBinding_valueChanged(newValue:Bool){
        self.hidden = newValue
    }
}