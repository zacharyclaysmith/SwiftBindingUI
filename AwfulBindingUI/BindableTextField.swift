//
//  BindableTextField.swift
//  ARWorld
//
//  Created by Zachary Smith on 12/22/14.
//  Copyright (c) 2014 Scal.io. All rights reserved.
//

import Foundation
import UIKit
import AwfulBinding

public class BindableTextField:UITextField{
    private var _bindableValue:BindableValue<String>?
    
    public var bindableValue:BindableValue<String>?{
        get{
            return _bindableValue
        }
        
        set(newValue){
            //_bindableValue?.removeListener(valueChanged)
            
            _bindableValue = newValue
            
            _bindableValue?.addListener(self, listener:valueChanged, alertNow: true)
        }
    }
    
    override init() {
        super.init()
    
        self.addTarget(self, action: Selector("textChanged"), forControlEvents: UIControlEvents.EditingChanged)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addTarget(self, action: Selector("textChanged"), forControlEvents: UIControlEvents.EditingChanged)
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.addTarget(self, action: Selector("textChanged"), forControlEvents: UIControlEvents.EditingChanged)
    }
    
    internal func textChanged(){
        _bindableValue?.value = self.text
    }
    
    private func valueChanged(newValue:String?){
        self.text = newValue
    }
}