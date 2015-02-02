//
//  BindableImageView.swift
//  ARWorld
//
//  Created by Zachary Smith on 12/22/14.
//  Copyright (c) 2014 Scal.io. All rights reserved.
//

import Foundation
import UIKit
import AwfulBinding

public class BindableImageView:UIImageView
{
    private var _nilImage:UIImage?
    public var nilImage:UIImage?{
        get{
            return _nilImage
        }
        set(value){
            _nilImage = value
            
            if(self.image == nil){
                self.image = _nilImage
            }
        }
    }
    
    private var _bindableValue:BindableValue<UIImage>?
    
    public var bindableValue:BindableValue<UIImage>?{
        get{
            return _bindableValue
        }
        
        set(newValue){
            _bindableValue = newValue
            
            _bindableValue?.addListener(self, listener:valueChanged, alertNow:true)
        }
    }
    
//    override public var image:UIImage?{
//        get{
//            return super.image
//        }
//        set(newValue){
//            super.image = newValue
//            
//            //_bindableValue?.value = super.image
//        }
//    }
    
    private func valueChanged(newValue:UIImage?){
        self.image = newValue != nil ? newValue : _nilImage //NOTE: if both newValue and _nilImage are nil, this will still result in the image being set to nil.
    }
}