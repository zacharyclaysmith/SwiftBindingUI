//
//  UIView-Extensions.swift
//  SwiftBindingUI
//
//  Created by Zachary Smith on 6/11/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//

import Foundation
import UIKit

public extension UIView{
  @IBInspectable public var cornerRadius:CGFloat{
    get{
      return self.layer.cornerRadius
    }
    set(value){
      self.layer.cornerRadius = value
    }
  }
  
  @IBInspectable public var borderColor:UIColor?{
    get{
      return self.layer.borderColor != nil ? UIColor(CGColor: self.layer.borderColor!) : nil
    }
    set(value){
      self.layer.borderColor = value?.CGColor
    }
  }
  
  @IBInspectable public var borderWidth:CGFloat{
    get{
      return self.layer.borderWidth
    }
    set(value){
      self.layer.borderWidth = value
    }
  }
  
  public func loadNib<T:UIView>(nib:String) -> T{
    let view = NSBundle.mainBundle().loadNibNamed(nib, owner: self, options: nil).first as? T
    
    assert(view != nil, "Could not load nib '" + nib + "'.")
    
    return view!
  }
  
  public func addNibToView(nib:String, hidden:Bool = false) -> UIView{
    let view = loadNib(nib)
    
    view.hidden = hidden
    
    self.addSubview(view)
    
    return view
  }
  
  public func constrainToTopMargin(parent:UIView, margin:CGFloat = 0) -> NSLayoutConstraint{
    self.translatesAutoresizingMaskIntoConstraints = false
    
    let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.TopMargin, relatedBy: NSLayoutRelation.Equal, toItem: parent, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: margin)
    
    parent.addConstraint(constraint)
    
    return constraint
  }
  
  public func constrainToBottomMargin(parent:UIView, margin:CGFloat = 0) -> NSLayoutConstraint{
    self.translatesAutoresizingMaskIntoConstraints = false
    
    let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.BottomMargin, relatedBy: NSLayoutRelation.Equal, toItem: parent, attribute: NSLayoutAttribute.BottomMargin, multiplier: 1, constant: margin)
    
    parent.addConstraint(constraint)
    
    return constraint
  }
  
  public func constrainToLeading(parent:UIView, margin:CGFloat = 0) -> NSLayoutConstraint{
    self.translatesAutoresizingMaskIntoConstraints = false
    
    let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: parent, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: margin)
    
    parent.addConstraint(constraint)
    
    return constraint
  }
  
  public func constrainToTrailing(parent:UIView, margin:CGFloat = 0) -> NSLayoutConstraint{
    self.translatesAutoresizingMaskIntoConstraints = false
    
    let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: parent, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: margin)
    
    parent.addConstraint(constraint)
    
    return constraint
  }
  
  public func constrainToParent(parent:UIView, margin:CGFloat = 0) -> [NSLayoutConstraint]{
    var constraints = [NSLayoutConstraint]()
    
    constraints.append(constrainToTopMargin(parent, margin: margin))
    constraints.append(constrainToBottomMargin(parent, margin: -margin))
    constraints.append(constrainToLeading(parent, margin: margin))
    constraints.append(constrainToTrailing(parent, margin: -margin))
    
    return constraints
  }
  
  public func constrainHeight(value:CGFloat) -> NSLayoutConstraint{
    self.translatesAutoresizingMaskIntoConstraints = false
    
    let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: value)
    
    self.addConstraint(constraint)
    
    return constraint
  }
  
  public func constrainWidth(value:CGFloat) -> NSLayoutConstraint{
    self.translatesAutoresizingMaskIntoConstraints = false
    
    let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: value)
    
    self.addConstraint(constraint)
    
    return constraint
  }
  
  public func constrainHeightToParent(parent:UIView, multiplier:CGFloat = 1.0) -> NSLayoutConstraint{
    self.translatesAutoresizingMaskIntoConstraints = false
    
    let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: parent, attribute: NSLayoutAttribute.Height, multiplier: multiplier, constant: 0)
    
    parent.addConstraint(constraint)
    
    return constraint
  }
  
  public func constrainToParentCenterX(parent:UIView, multiplier:CGFloat = 1.0, constant:CGFloat = 0) -> NSLayoutConstraint{
    self.translatesAutoresizingMaskIntoConstraints = false
    
    let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.CenterXWithinMargins, relatedBy: NSLayoutRelation.Equal, toItem: parent, attribute: NSLayoutAttribute.CenterXWithinMargins, multiplier: multiplier, constant: constant)
    
    parent.addConstraint(constraint)
    
    return constraint
  }
  
  public func constrainToParentCenterY(parent:UIView, multiplier:CGFloat = 1.0, constant:CGFloat = 0) -> NSLayoutConstraint{
    self.translatesAutoresizingMaskIntoConstraints = false
    
    let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.CenterYWithinMargins, relatedBy: NSLayoutRelation.Equal, toItem: parent, attribute: NSLayoutAttribute.CenterYWithinMargins, multiplier: multiplier, constant: constant)
    
    parent.addConstraint(constraint)
    
    return constraint
  }
  
  public func makeCircular(){
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.clipsToBounds = true;
  }
}