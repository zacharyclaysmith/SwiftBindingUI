import UIKit
import AwfulBinding

public class BindableTableView : UITableView, UITableViewDataSource, UITableViewDelegate{
    //HACK: convenience method...you probably shouldn't override this in descendent classes.
    public var singleSection:PBindableCollection?{
        get{
            if(_sections != nil && _sections!.count > 0){
                return _sections![0].data
            } else {
                return nil
            }
        }
        set(value){
            if(value != nil){
                let defaultSection = BindableTableSection(data: value)
                
                //HACK: to add bindings
                self.sections = BindableArray<BindableTableSection>(initialArray: [defaultSection])
            }
            else{
                _sections = nil
            }
        }
    }
    
    private var _sections:BindableArray<BindableTableSection>?
    public var sections:BindableArray<BindableTableSection>?{
        get{
            return _sections
        }
        set(value){
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
    
    public var deleteHandler:((indexPath:NSIndexPath) -> Void)?
    
    private func sectionedDataChangedListener(){
        for section in _sections!.internalArray {
            section.data?.addChangedListener(self, listener: sectionChangedListener, alertNow: false)
            section.data?.addIndexChangedListener(self, listener: sectionIndexChangedListener)
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
        return viewForHeaderInSection?(sectionIndex: section)
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(_sections != nil){
            assert(section < _sections!.count, "Can't get the number of rows for a section outside of the bounds of the sectioned data.") //TODO: better error message
           
            let section = _sections![section]
            
            return section.data!.count
        } else{
            return 0
        }
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return _sections != nil ? _sections!.count : 0
    }
    
    public var cellForRowAtIndexPath:((indexPath:NSIndexPath) -> UITableViewCell)?
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return cellForRowAtIndexPath != nil ? cellForRowAtIndexPath!(indexPath: indexPath) : UITableViewCell()
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
    
    public var onSelect:((indexPath:NSIndexPath) -> Void)?
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        onSelect?(indexPath: indexPath)
    }
}