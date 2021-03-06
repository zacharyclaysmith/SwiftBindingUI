//
//  BindableSection.swift
//  SwiftBindingUI
//
//  Created by Zachary Smith on 2/12/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//

import Foundation
import SwiftBinding

public protocol PBindableTableSection{
  var headerText:String? {get set}
  var headerViewCreator:(() -> UIView)? {get set}
  var footerText:String? {get set}
  var footerViewCreator:(() -> UIView)? {get set}
  
  var tableData:PBindableCollection! {get}
  
  var createCell:((index:Int) -> UITableViewCell)? {get set}
  var onSelect:((index:Int) -> Void)? {get set}
}

public class BindableTableSection<T>:PBindableTableSection{
    public var headerText:String?
    public var headerViewCreator:(() -> UIView)?
  public var footerText:String?
  public var footerViewCreator:(() -> UIView)?
  
    //EXPL: used by the BindableTableView to avoid dependency on generics (maybe Apple will make this not such a big deal later).
    public var tableData:PBindableCollection!{
        return self.data
    }
    
    public var data:BindableArray<T>!
    
    public var createCell:((index:Int) -> UITableViewCell)?
    
    public var onSelect:((index:Int) -> Void)?
    
    public init(data:BindableArray<T>, createCell:((index:Int) -> UITableViewCell)? = nil){
        self.data = data
        self.createCell = createCell
    }
    
    public convenience init(data:BindableArray<T>, headerText:String?, createCell:((index:Int) -> UITableViewCell)? = nil){
        self.init(data:data, createCell:createCell)
        
        self.headerText = headerText
    }
    
    public convenience init(data:BindableArray<T>, headerViewCreator:(() -> UIView)?, createCell:((index:Int) -> UITableViewCell)? = nil){
        self.init(data:data, createCell:createCell)
        
        self.headerViewCreator = headerViewCreator
    }
}