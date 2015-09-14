//
//  SwiftTextField.swift
//  SwiftBindingUI
//
//  Created by Zachary Smith on 6/11/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//
import Foundation
import UIKit

public class SwiftTextField:UITextField, UITextFieldDelegate{
  public var onEditingStarting:(() -> Void)?
  public var onEditingEnding:(() -> Void)?
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    
    commonInit()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    commonInit()
  }
  
  internal func commonInit(){
    self.delegate = self //TODO: override this setter and alert when this is set to something other than self (do this for most of these components as well)
    
    self.addTarget(self, action: Selector("textChanged"), forControlEvents: UIControlEvents.EditingChanged)
  }
  
  internal func textChanged(){
    onTextChanged?(text: self.text!)
  }
  
  public var onTextChanged:((text:String) -> Void)?
  
  //#pragma UITextFieldDelegate wrappers
  public var shouldBeginEditing:(() -> Bool)?
  public func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    return shouldBeginEditing?() ?? true
  }
  
  public var shouldEndEditing:(() -> Bool)?
  public func textFieldShouldEndEditing(textField: UITextField) -> Bool {
    return shouldEndEditing?() ?? true
  }
  
  public var shouldChangeCharactersInRange:((range:NSRange, string:String) -> Bool)?
  public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    return shouldChangeCharactersInRange?(range:range, string:string) ?? true
  }
  
  public var didBeginEditing:(() -> Void)?
  public func textFieldDidBeginEditing(textField: UITextField) {
    didBeginEditing?()
  }
  
  public var didEndEditing:(() -> Void)?
  public func textFieldDidEndEditing(textField: UITextField) {
    didEndEditing?()
  }
  
  public var shouldClear:(() -> Bool)?
  public func textFieldShouldClear(textField: UITextField) -> Bool {
    return shouldClear?() ?? true
  }
  
  public var shouldReturn:(() -> Bool)?
  public func textFieldShouldReturn(textField: UITextField) -> Bool {
    return shouldReturn?() ?? true
  }
}
