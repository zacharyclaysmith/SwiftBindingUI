//
//  BindableSearchBar.swift
//  cartonomy
//
//  Created by Zachary Smith on 1/27/15.
//  Copyright (c) 2015 scal.io. All rights reserved.
//

import Foundation
import UIKit
import AwfulBinding

public class BindableSearchBar:UISearchBar, UISearchBarDelegate{
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
        
        self.delegate = self
        
//        self.addTarget(self, action: Selector("textChanged"), forControlEvents: UIControlEvents.EditingChanged)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.delegate = self
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.delegate = self
    }
    
    public func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        textChanged()
    }
    
    internal func textChanged(){
        _bindableValue?.value = self.text
    }
    
    private func valueChanged(newValue:String?){
        self.text = newValue
    }
}