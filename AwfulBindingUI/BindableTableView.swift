import UIKit
import AwfulBinding

public class BindableTableView : UITableView, UITableViewDataSource, UITableViewDelegate{
    private var _bindableArray:PBindableCollection?
    public var bindableArray:PBindableCollection?{
        get{
            return _bindableArray
        }
        set(value){
            _bindableArray = value
            
            _bindableArray?.addChangedListener(self, listener:arrayChangedListener, alertNow: true)
            
            _bindableArray?.addIndexChangedListener(self, listener:indexChangedListener)
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
    
    private func arrayChangedListener(){
        self.reloadData()
    }
    
    private func indexChangedListener(indexChanged:Int){
        self.reloadData()
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _bindableArray != nil ? _bindableArray!.count : 0
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
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