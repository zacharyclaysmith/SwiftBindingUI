//
//  SwiftTextView.swift
//  SwiftBindingUI
//
//  Created by Zachary Smith on 6/11/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//

import Foundation
import UIKit

public class SwiftTextView:UITextView{
  public override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("textChanged"), name: UITextViewTextDidChangeNotification, object: self)
  }
  
  public required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("textChanged"), name: UITextViewTextDidChangeNotification, object: self)
  }
  
  public var onTextChanged:((text:String) -> Void)?
  internal func textChanged(){
    onTextChanged?(text: self.text)
  }
  
  private func valueChanged(newValue:String){
    self.text = newValue
  }
}