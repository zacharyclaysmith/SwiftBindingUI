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

public class BindableButton:UIButton, PTextBindable, PHiddenBindable{
    private var _enabledBinding:BindableValue<Bool>?
    
    public var enabledBinding:BindableValue<Bool>?{
        get{
            return _enabledBinding
        }
        
        set(newValue){
            _enabledBinding?.removeListener(self)
            
            _enabledBinding = newValue
            
            _enabledBinding?.addListener(self, alertNow: true, listener:valueChanged)
        }
    }
    
    private var _textBinding:BindableValue<String>?
    
    public var textBinding:BindableValue<String>?{
        get{
            return _textBinding
        }
        
        set(newValue){
            _textBinding?.removeListener(self)
            
            _textBinding = newValue
            
            _textBinding?.addListener(self, alertNow: true, listener:textBindingChanged)
        }
    }
    
    deinit{
        _enabledBinding?.removeListener(self)
        _hiddenBinding?.removeListener(self)
    }
    
    private func valueChanged(newValue:Bool){
        self.enabled = newValue
    }
    
    private func textBindingChanged(newValue:String){
        self.setTitle(newValue, forState: UIControlState.Normal)
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
    
    //TODO: segment by control state
    private var _imageBinding:BindableValue<UIImage?>?
    public var imageBinding:BindableValue<UIImage?>?{
        get{
            return _imageBinding
        }
        
        set(newValue){
            _imageBinding?.removeListener(self)
            
            _imageBinding = newValue
            
            _imageBinding?.addListener(self, alertNow: true, listener:imageBinding_valueChanged)
        }
    }
    
    private func imageBinding_valueChanged(newValue:UIImage?){
        self.setImage(newValue, forState: UIControlState.Normal)
    }
}