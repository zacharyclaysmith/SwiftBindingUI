import UIKit
import AwfulBinding

public class BoundTableViewDelegate : NSObject, UITableViewDataSource, UITableViewDelegate{
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
    
    public var deleteHandler:((indexPath:NSIndexPath) -> Void)?
    
    private func arrayChangedListener(){
        assert(tableView != nil, "tableView property cannot be nil.")
        
        self.tableView!.reloadData()
    }
    
    private func indexChangedListener(indexChanged:Int){
        assert(tableView != nil, "tableView property cannot be nil.")
        
        self.tableView!.reloadData()
    }
    
    public var tableView:UITableView?
    
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