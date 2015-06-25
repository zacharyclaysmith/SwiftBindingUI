import UIKit
import SwiftBinding

public class BindableTableView : SwiftTableView, PHiddenBindable{
  //HACK: convenience method...you probably shouldn't override this in descendent classes.
  //DEPRECATED: use dataSection
  public var singleSection:PBindableTableSection?{
    get{
      return self.dataSection
    }
    set(value){
      self.dataSection = value
    }
  }
  
  public var dataSection:PBindableTableSection?{
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
        self.sections = BindableArray<PBindableTableSection>(internalArray: [value!])
      }
      else{
        _sections = nil
      }
    }
  }
  
  public var dataSections:BindableArray<PBindableTableSection>?{
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
  
    private var _sections:BindableArray<PBindableTableSection>?
  
  //DEPRECATED: use dataSections
    public var sections:BindableArray<PBindableTableSection>?{
        get{
            return self.dataSections
        }
        set(value){
            self.dataSections = value
        }
    }
    
    deinit{
        _sections?.removeChangedListener(self)
        _sections?.removeIndexChangedListener(self)
        
        _hiddenBinding?.removeListener(self)
        //TODO:remove child listeners
    }
    
    public var deleteHandler:((indexPath:NSIndexPath) -> Void)?
    
    private func sectionedDataChangedListener(){
        for section in _sections!.internalArray {
            section.tableData?.addChangedListener(self, alertNow: false, listener: sectionChangedListener)
            section.tableData?.addIndexChangedListener(self, listener: sectionIndexChangedListener)
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
  
  public override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return _sections?[section].headerText ?? super.tableView(tableView, titleForHeaderInSection: section)
  }
  
  public override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return _sections?[section].headerViewCreator?() ?? super.tableView(tableView, viewForHeaderInSection: section)
  }
  
  public override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return _sections?[section].footerText ?? super.tableView(tableView, titleForFooterInSection: section)
  }
  
  public override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return _sections?[section].footerViewCreator?() ?? super.tableView(tableView, viewForFooterInSection: section)
  }
    
    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(_sections != nil){
            assert(section < _sections!.count, "Can't get the number of rows for a section outside of the bounds of the sectioned data.") //TODO: better error message
            
            let section = _sections![section]
            
            return section.tableData!.count
        } else{
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    public override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return _sections?.count ?? super.numberOfSectionsInTableView(tableView)
    }
    
    //Used if a section doesn't have a cellCreator set.
    //DEPRECATED: currently uses complex and inefficient closure wrappers to mimic old functionality.
  public var defaultCellCreator:((sectionIndex:Int, index:Int) -> UITableViewCell)?{
    get{
      var wrapperClosure:((sectionIndex:Int, index:Int) -> UITableViewCell)? = nil
      
      if(self.cellForRowAtIndexPath != nil){
        wrapperClosure = {(sectionIndex:Int, index:Int) -> UITableViewCell in
          return self.cellForRowAtIndexPath!(indexPath:NSIndexPath(forRow: index, inSection: sectionIndex)!)
        }
      }
      
      return wrapperClosure
    }
    
    set(value){
      if(value != nil){
        self.cellForRowAtIndexPath = {(indexPath:NSIndexPath) -> UITableViewCell in
          return value!(sectionIndex: indexPath.section, index: indexPath.row)
        }
      }else{
        self.cellForRowAtIndexPath = nil
      }
    }
  }
    
  public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return _sections?[indexPath.section].createCell?(index: indexPath.row) ?? super.tableView(tableView, cellForRowAtIndexPath:indexPath)
  }
  
  public override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    super.tableView(tableView, commitEditingStyle: editingStyle, forRowAtIndexPath: indexPath)
    
    //DEPRECATED: needs to be handled differently in the future.
    switch(editingStyle)
    {
    case UITableViewCellEditingStyle.Delete:
        deleteHandler?(indexPath:indexPath)
        break
    default:
        break
    }
  }
  
  public var reloadOnSelect:Bool = false
  
  public var onSelect:((section:PBindableTableSection, index:Int) -> Void)?
  
  public override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
    
    _sections?[indexPath.section].onSelect?(index:indexPath.row)
    
    if(_sections != nil){
      onSelect?(section:_sections![indexPath.section], index:indexPath.row)
    }

    if(reloadOnSelect){
        tableView.reloadData()
    }
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