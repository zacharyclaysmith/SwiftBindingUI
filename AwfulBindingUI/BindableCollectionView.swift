//
//  FlowLayout.swift
//  cartonomy
//
//  Created by Zachary Smith on 2/4/15.
//  Copyright (c) 2015 scal.io. All rights reserved.
//

import Foundation
import UIKit
import AwfulBinding

public class BindableCollectionView:UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    private var _bindableArray:PBindableCollection?
    public var bindableArray:PBindableCollection?{
        get{
            return _bindableArray
        }
        set(value){
            _bindableArray?.removeChangedListener(self)
            _bindableArray?.removeIndexChangedListener(self)
            
            _bindableArray = value
            
            _bindableArray?.addChangedListener(self, listener:arrayChangedListener, alertNow: true)
            
            _bindableArray?.addIndexChangedListener(self, listener:indexChangedListener)
        }
    }
    
    private var _showFooterBinding:BindableValue<Bool>?
    public var showFooterBinding:BindableValue<Bool>?{
        get{
            return _showFooterBinding
        }
        set(value){
            _showFooterBinding = value
            
            _showFooterBinding?.addListener(self, listener: showFooterChangedListener, alertNow: true)
        }
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        
        self.delegate = self
        self.dataSource = self
    }
    
    override init() {
        super.init()
        
        self.delegate = self
        self.dataSource = self
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        self.delegate = self
        self.dataSource = self
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame:frame, collectionViewLayout:layout)
        
        self.delegate = self
        self.dataSource = self
    }
    
    deinit{
        _bindableArray?.removeChangedListener(self)
        _bindableArray?.removeIndexChangedListener(self)
    }
    
    private func showFooterChangedListener(value:Bool?){
        self.reloadData()
    }
    
    private func arrayChangedListener(){
        self.reloadData()
    }
    
    private func indexChangedListener(indexChanged:Int){
        self.reloadData()
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _bindableArray != nil ? _bindableArray!.count : 0
    }
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public var cellForItemAtIndexPath:((indexPath:NSIndexPath) -> UICollectionViewCell)?
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        assert(cellForItemAtIndexPath != nil, "No cellForItemAtIndexPath method was specified.")
        
        return cellForItemAtIndexPath!(indexPath: indexPath)
    }
    
    public var onHeaderCreation:((header:UICollectionReusableView) -> Void)?
    public var onFooterCreation:((footer:UICollectionReusableView) -> Void)?
    
    public var headerReuseIdentifier:String?
    public var footerReuseIdentifier:String?
    
    public func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        var reusableView:UICollectionReusableView? = nil
        
        if(kind == UICollectionElementKindSectionHeader){
            assert(headerReuseIdentifier != nil, "Tried to create a supplementary element of kind UICollectionElementKindSectionHeader without setting the headerReuseIdentifier.")
            
            var header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerReuseIdentifier!, forIndexPath: indexPath) as UICollectionReusableView

            onHeaderCreation?(header:header)
            
            reusableView = header
        }else if(kind == UICollectionElementKindSectionFooter) {
            assert(footerReuseIdentifier != nil, "Tried to create a supplementary element of kind UICollectionElementKindSectionHeader without setting the footerReuseIdentifier.")
            
            var footer = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: footerReuseIdentifier!, forIndexPath: indexPath) as UICollectionReusableView
            
            onFooterCreation?(footer:footer)
            
            reusableView = footer
        }
        
        assert(reusableView != nil, "The supplementary view was not set to a valid object.")
        
        return reusableView!
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if(collectionViewLayout is UICollectionViewFlowLayout
            && showFooterBinding != nil
            && showFooterBinding!.value){
            return (collectionViewLayout as UICollectionViewFlowLayout).footerReferenceSize
        } else{
            return CGSizeZero
        }
    }
    
    private var _selectedIndex:NSIndexPath?
    public var selectedIndex:NSIndexPath?{
        get{
            return _selectedIndex
        }
    }
    public var onSelectedIndex:((indexPath:NSIndexPath) -> Void)?
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        _selectedIndex = indexPath
        
        onSelectedIndex?(indexPath: indexPath)
    }
}