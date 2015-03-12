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
            _enabledBinding?.removeListener(self)
            
            _enabledBinding = newValue
            
            _enabledBinding?.addListener(self, listener:valueChanged, alertNow: true)
        }
    }
    
    deinit{
        _enabledBinding?.removeListener(self)
        _hiddenBinding?.removeListener(self)
    }
    
    private func valueChanged(newValue:Bool){
        self.enabled = newValue
    }
    
    private var _hiddenBinding:BindableValue<Bool>?
    
    public var hiddenBinding:BindableValue<Bool>?{
        get{
            return _hiddenBinding
        }
        
        set(newValue){
            _hiddenBinding?.removeListener(self)
            
            _hiddenBinding = newValue
            
            _hiddenBinding?.addListener(self, listener:hiddenBinding_valueChanged, alertNow: true)
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
            
            _imageBinding?.addListener(self, listener:imageBinding_valueChanged, alertNow: true)
        }
    }
    
    private func imageBinding_valueChanged(newValue:UIImage?){
        self.setImage(newValue, forState: UIControlState.Normal)
    }
}