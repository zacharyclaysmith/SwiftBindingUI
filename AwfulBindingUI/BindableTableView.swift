import UIKit
import AwfulBinding

public class BindableTableView : UITableView, UITableViewDataSource, UITableViewDelegate, PHiddenBindable{
    //HACK: convenience method...you probably shouldn't override this in descendent classes.
    public var singleSection:PBindableTableSection?{
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
    
    private var _sections:BindableArray<PBindableTableSection>?
    public var sections:BindableArray<PBindableTableSection>?{
        get{
            return _sections
        }
        set(value){
            _sections?.removeChangedListener(self)
            _sections?.removeIndexChangedListener(self)
            
            _sections = value
            
            _sections?.addChangedListener(self, listener:sectionedDataChangedListener, alertNow: true)
            
            _sections?.addIndexChangedListener(self, listener:sectionedDataIndexChangedListener)
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
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame:frame, style:style)
        
        self.delegate = self
        self.dataSource = self
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
            section.tableData?.addChangedListener(self, listener: sectionChangedListener, alertNow: false)
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
    
    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = _sections?[section]
        
        return section?.headerText
    }
    
    public var viewForHeaderInSection:((sectionIndex:Int) -> UIView?)?
    public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //TODO: sections should have header generators
        
        return viewForHeaderInSection?(sectionIndex: section)
    }
    
    public var viewForFooterInSection:((sectionIndex:Int) -> UIView?)?
    public func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //TODO: sections should have footer generators
        
        return viewForFooterInSection?(sectionIndex: section)
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(_sections != nil){
            assert(section < _sections!.count, "Can't get the number of rows for a section outside of the bounds of the sectioned data.") //TODO: better error message
            
            let section = _sections![section]
            
            return section.tableData!.count
        } else{
            return 0
        }
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return _sections != nil ? _sections!.count : 0
    }
    
    //Used if a section doesn't have a cellCreator set.
    public var defaultCellCreator:((sectionIndex:Int, index:Int) -> UITableViewCell)?
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        assert(_sections != nil, "The sections property cannot be nil when drawing the table.")
        
        let section = _sections![indexPath.section]
        
        var cell:UITableViewCell!
        
        if(section.createCell != nil){
            cell = section.createCell!(index: indexPath.row)
        }
        else if(defaultCellCreator != nil){
            cell = defaultCellCreator!(sectionIndex:indexPath.section, index:indexPath.row)
        }
        else{
            assertionFailure("No cell creator was found for section index " + String(indexPath.section) + ", and no default cell creator was set for the table.")
        }
        
        return cell
    }
    
    public func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
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
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var section = _sections![indexPath.section]
        
        section.onSelect?(index:indexPath.row)
        onSelect?(section:section, index:indexPath.row)
        
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
            
            _hiddenBinding?.addListener(self, listener:hiddenBinding_valueChanged, alertNow: true)
        }
    }
    private func hiddenBinding_valueChanged(newValue:Bool){
        self.hidden = newValue
    }
}