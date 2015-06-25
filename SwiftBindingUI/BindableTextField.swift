//
//  BindableTextField.swift
//  ARWorld
//
//  Created by Zachary Smith on 12/22/14.
//  Copyright (c) 2014 Scal.io. All rights reserved.
//

import Foundation
import UIKit
import SwiftBinding

public class BindableTextField:SwiftTextField, PTextBindable, PHiddenBindable{
    private var _textBinding:BindableValue<String>?
    
    //DEPRECATED: remove for 1.0
    public var bindableValue:BindableValue<String>?{
        get{
            return _textBinding
        }
        
        set(newValue){
            _textBinding?.removeListener(self)
            
            _textBinding = newValue
            
            _textBinding?.addListener(self, alertNow: true, listener:boundValueChanged)
        }
    }
    
    public var textBinding:BindableValue<String>?{
        get{
            return _textBinding
        }
        
        set(newValue){
            _textBinding?.removeListener(self)
            
            _textBinding = newValue
            
            _textBinding?.addListener(self, alertNow: true, listener:boundValueChanged)
        }
    }
    
    deinit{
        _textBinding?.removeListener(self)
        _hiddenBinding?.removeListener(self)
    }
    
    internal override func textChanged(){
      if(_textBinding?.value != self.text){
          _textBinding?.value = self.text
      }
      
      super.textChanged()
    }
    
    private func boundValueChanged(newValue:String){
        self.text = newValue
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