//
//  FlowLayout.swift
//  cartonomy
//
//  Created by Zachary Smith on 2/4/15.
//  Copyright (c) 2015 scal.io. All rights reserved.
//

import Foundation
import UIKit
import SwiftBinding

public class BindableCollectionView:UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, PHiddenBindable{
    //HACK: convenience method...you probably shouldn't override this in descendent classes.
    public var singleSection:PBindableCollectionSection?{
        get{
            if(_sections != nil && _sections!.count > 0){
                return _sections![0]
            } else {
                return nil
            }
        }
        set(value){
            if(value != nil){
                //HACK: set to public property to add bindings properly, unsafe for subclassing.
                self.sections = BindableArray<PBindableCollectionSection>(internalArray: [value!])
            }
            else{
                _sections = nil
            }
        }
    }
    
    private var _sections:BindableArray<PBindableCollectionSection>?
    public var sections:BindableArray<PBindableCollectionSection>?{
        get{
            return _sections
        }
        set(value){
            _sections?.removeChangedListener(self)
            _sections?.removeIndexChangedListener(self)
            
            _sections = value
            
            _sections?.addChangedListener(self, alertNow: true, listener:sectionedDataChangedListener)
            
            _sections?.addIndexChangedListener(self, listener:sectionedDataIndexChangedListener)
        }
    }
    
    private func sectionedDataChangedListener(){
        for section in _sections!.internalArray {
            section.collectionData?.addChangedListener(self, alertNow: false, listener: sectionChangedListener)
            section.collectionData?.addIndexChangedListener(self, listener: sectionIndexChangedListener)
        }
        
        self.reloadData()
    }
    
    private func sectionIndexChangedListener(index:Int){
        self.reloadData()//TODO: only reload if displayed data is changed?
    }
    
    private func sectionChangedListener(){
        self.reloadData()//TODO: only reload if displayed data is changed?
    }
    
    private func sectionedDataIndexChangedListener(indexChanged:Int){
        //TODO: add listeners to new index?
        
        self.reloadData()//TODO: only reload if displayed data is changed?
    }
    
    private var _showFooterBinding:BindableValue<Bool>?
    public var showFooterBinding:BindableValue<Bool>?{
        get{
            return _showFooterBinding
        }
        set(value){
            _showFooterBinding = value
            
            _showFooterBinding?.addListener(self, alertNow: true, listener: showFooterChangedListener)
        }
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        
        self.delegate = self
        self.dataSource = self
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame:frame, collectionViewLayout:layout)
        
        self.delegate = self
        self.dataSource = self
    }
    
    deinit{
        _sections?.removeChangedListener(self)
        _sections?.removeIndexChangedListener(self)
        _hiddenBinding?.removeListener(self)
        
        //TODO:remove child listeners
    }
    
    private func showFooterChangedListener(value:Bool){
        self.reloadData()
    }
    
    private func arrayChangedListener(){
        self.reloadData()
    }
    
    private func indexChangedListener(indexChanged:Int){
        self.reloadData()
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(_sections != nil){
            assert(section < _sections!.count, "Can't get the number of rows for a section outside of the bounds of the sectioned data.") //TODO: better error message
            
            let section = _sections![section]
            
            return section.collectionData!.count
        } else{
            return 0
        }
    }
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return _sections != nil ? _sections!.count : 0
    }
    
    //Used if a section doesn't have a cellCreator set.
    public var defaultCellCreator:((sectionIndex:Int, index:Int, indexPath:NSIndexPath) -> UICollectionViewCell)?
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        assert(_sections != nil, "The sections property cannot be nil when drawing the table.")
        
        let section = _sections![indexPath.section]
        
        var cell:UICollectionViewCell!
        
        if(section.createCell != nil){
            cell = section.createCell!(index: indexPath.row, indexPath:indexPath)
        }
        else if(defaultCellCreator != nil){
            cell = defaultCellCreator!(sectionIndex:indexPath.section, index:indexPath.row, indexPath:indexPath)
        }
        else{
            assertionFailure("No cell creator was found for section index " + String(indexPath.section) + ", and no default cell creator was set for the table.")
        }
        
        return cell
    }
    
    public var onHeaderCreation:((header:UICollectionReusableView) -> Void)?
    public var onFooterCreation:((footer:UICollectionReusableView) -> Void)?
    
    public var headerReuseIdentifier:String?
    public var footerReuseIdentifier:String?
    
    public func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        var reusableView:UICollectionReusableView? = nil
        
        if(kind == UICollectionElementKindSectionHeader){
            assert(headerReuseIdentifier != nil, "Tried to create a supplementary element of kind UICollectionElementKindSectionHeader without setting the headerReuseIdentifier.")
            
            var header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerReuseIdentifier!, forIndexPath: indexPath) as! UICollectionReusableView

            onHeaderCreation?(header:header)
            
            reusableView = header
        }else if(kind == UICollectionElementKindSectionFooter) {
            assert(footerReuseIdentifier != nil, "Tried to create a supplementary element of kind UICollectionElementKindSectionHeader without setting the footerReuseIdentifier.")
            
            var footer = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: footerReuseIdentifier!, forIndexPath: indexPath) as! UICollectionReusableView
            
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
            return (collectionViewLayout as! UICollectionViewFlowLayout).footerReferenceSize
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