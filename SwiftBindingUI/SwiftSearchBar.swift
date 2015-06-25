//
//  SwiftSearchBar.swift
//  SwiftBindingUI
//
//  Created by Zachary Smith on 6/11/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//
import Foundation
import UIKit
import SwiftBinding

public class SwiftSearchBar:UISearchBar, UISearchBarDelegate{
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.delegate = self
  }
  
  public required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.delegate = self
  }
  
  public var onTextChanged:((text:String) -> Void)?
  internal func textChanged(){
    onTextChanged?(text:self.text)
  }
  public func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    textChanged()
  }
  
  public var didBeginEditing:(() -> Void)?
  public func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
    didBeginEditing?()
  }
  
  public var didEndEditing:(() -> Void)?
  public func searchBarTextDidEndEditing(searchBar: UISearchBar) {
    didEndEditing?()
  }
  
  public var searchButtonClicked:(() -> Void)?
  public func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchButtonClicked?()
  }
  
  public var cancelButtonClick:(() -> Void)?
  public func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    cancelButtonClick?()
  }
  
  public var selectedScopeButtonIndexDidChange:((selectedScope:Int) -> Void)?
  public func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    selectedScopeButtonIndexDidChange?(selectedScope: selectedScope)
  }
  
  public var shouldChangeTextInRange:((range:NSRange, text:String) -> Bool)?
  public func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    return shouldChangeTextInRange?(range:range, text:text) ?? true
  }
  
  public var bookmarkButtonClicked:(() -> Void)?
  public func searchBarBookmarkButtonClicked(searchBar: UISearchBar) {
    bookmarkButtonClicked?()
  }
  
  public var resultsListButtonClicked:(() -> Void)?
  public func searchBarResultsListButtonClicked(searchBar: UISearchBar) {
    resultsListButtonClicked?()
  }
  
  public var shouldBeginEditing:(() -> Bool)?
  public func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
    return shouldBeginEditing?() ?? true
  }
  
  public var shouldEndEditing:(() -> Bool)?
  public func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
    return shouldEndEditing?() ?? true
  }
}
