//
//  BindableSearchBar.swift
//  cartonomy
//
//  Created by Zachary Smith on 1/27/15.
//  Copyright (c) 2015 scal.io. All rights reserved.
//

import Foundation
import UIKit
import SwiftBinding

public class BindableSearchBar:UISearchBar, UISearchBarDelegate, PTextBindable, PHiddenBindable{
    private var _textBinding:BindableValue<String>?
    
    //DEPRECATED
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.delegate = self
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.delegate = self
    }
    
    deinit{
        _textBinding?.removeListener(self)
        _hiddenBinding?.removeListener(self)
    }
    
    public func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        textChanged()
    }
    
    public var onBeginEditing:(() -> Void)?
    
    public var onEndEditing:(() -> Void)?
    
    public func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        onBeginEditing?()
    }
    
    public func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        onEndEditing?()
    }
    
    public var onSearchButtonClick:(() -> Void)?
    public func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        onSearchButtonClick?()
    }
    
    public var onCancelButtonClick:(() -> Void)?
    public func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        onCancelButtonClick?()
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
}