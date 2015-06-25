//
//  BindableImageView.swift
//  ARWorld
//
//  Created by Zachary Smith on 12/22/14.
//  Copyright (c) 2014 Scal.io. All rights reserved.
//

import Foundation
import UIKit
import SwiftBinding

public class BindableImageView:UIImageView, PHiddenBindable
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
  
  private var _imageBinding:BindableValue<UIImage?>?
  
  public var imageBinding:BindableValue<UIImage?>?{
    get{
      return _imageBinding
    }
    
    set(newValue){
      _imageBinding?.removeListener(self)
      
      _imageBinding = newValue
      
      _imageBinding?.addListener(self, alertNow:true, listener:valueChanged)
    }
  }
  
  deinit{
      _imageBinding?.removeListener(self)
      _hiddenBinding?.removeListener(self)
  }
  
  private func valueChanged(newValue:UIImage?){
      self.image = newValue != nil ? newValue : _nilImage //NOTE: if both newValue and _nilImage are nil, this will still result in the image being set to nil.
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