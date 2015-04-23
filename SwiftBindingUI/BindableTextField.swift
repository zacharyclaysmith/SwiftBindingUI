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

public class BindableTextField:UITextField, UITextFieldDelegate, PTextBindable, PHiddenBindable{
    public var onEditingStarting:(() -> Void)?
    public var onEditingEnding:(() -> Void)?
    
    private var _textBinding:BindableValue<String>?
    
    //DEPRECATED: remove for 1.0
    public var bindableValue:BindableValue<String>?{
        get{
            return _textBinding
        }
        
        set(newValue){
            _textBinding?.removeListener(self)
            
            _textBinding = newValue
            
            _textBinding?.addListener(self, alertNow: true, listener:valueChanged)
        }
    }
    
    public var textBinding:BindableValue<String>?{
        get{
            return _textBinding
        }
        
        set(newValue){
            _textBinding?.removeListener(self)
            
            _textBinding = newValue
            
            _textBinding?.addListener(self, alertNow: true, listener:valueChanged)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    internal func commonInit(){
        self.delegate = self //TODO: override this setter and alert when this is set to something other than self (do this for most of these components as well)
        
        self.addTarget(self, action: Selector("textChanged"), forControlEvents: UIControlEvents.EditingChanged)
    }
    
    deinit{
        _textBinding?.removeListener(self)
        _hiddenBinding?.removeListener(self)
    }
    
    internal func textChanged(){
        if(_textBinding?.value != self.text){
            _textBinding?.value = self.text
        }
    }
    
    private func valueChanged(newValue:String){
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
    
    public func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        onEditingStarting?()
        
        return true
    }
    
    public func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        onEditingEnding?()
        
        return true
    }
}