import UIKit
import SwiftBinding

public class SwiftTableView : UITableView, UITableViewDataSource, UITableViewDelegate{
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder:aDecoder)
    
    commonInit()
  }
  
  override init(frame: CGRect, style: UITableViewStyle) {
    super.init(frame:frame, style:style)
    
    commonInit()
  }
  
  internal func commonInit(){
    self.delegate = self
    self.dataSource = self
  }
  
  public var titleForHeaderInSection:((section:Int) -> String?)?
  public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return titleForHeaderInSection?(section: section)
  }
  
  public var viewForHeaderInSection:((sectionIndex:Int) -> UIView?)?
  public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return viewForHeaderInSection?(sectionIndex: section)
  }
  
  public var viewForFooterInSection:((sectionIndex:Int) -> UIView?)?
  public func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return viewForFooterInSection?(sectionIndex: section)
  }
  
  public var numberOfRowsInSection:((section:Int) -> Int)?
  public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return numberOfRowsInSection?(section: section) ?? 0
  }
  
  public var numberOfSectionsInTableView:(() -> Int)?
  public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return numberOfSectionsInTableView?() ?? 0
  }
  
  public var cellForRowAtIndexPath:((indexPath:NSIndexPath) -> UITableViewCell)?
  public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return cellForRowAtIndexPath?(indexPath: indexPath) ?? UITableViewCell()
  }
  //
  //  public var canEditRowAtIndexPath:((indexPath:NSIndexPath) -> Bool)?
  //  public func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
  //    return canEditRowAtIndexPath?(indexPath: indexPath) ?? true
  //  }
  //
  public var commitEditingStyleForRowAtIndexPath:((editingStyle:UITableViewCellEditingStyle, indexPath:NSIndexPath) -> Void)?
  public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    commitEditingStyleForRowAtIndexPath?(editingStyle: editingStyle, indexPath: indexPath)
  }
  
  public var didSelectRowAtIndexPath:((indexPath:NSIndexPath) -> Void)?
  public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    didSelectRowAtIndexPath?(indexPath: indexPath)
  }
  
  public var accessoryButtonTappedForRowWithIndexPath:((indexPath:NSIndexPath) -> Void)?
  public func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
    accessoryButtonTappedForRowWithIndexPath?(indexPath: indexPath)
  }
  
//  public var accessoryTypeForRowWithIndexPath:((indexPath:NSIndexPath) -> UITableViewCellAccessoryType)?
//  public func tableView(tableView: UITableView, accessoryTypeForRowWithIndexPath indexPath: NSIndexPath!) -> UITableViewCellAccessoryType {
//    return accessoryTypeForRowWithIndexPath?(indexPath: indexPath) ?? UITableViewCellAccessoryType.None
//  }
  
  public var canMoveRowAtIndexPath:((indexPath:NSIndexPath) -> Bool)?
  public func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return canMoveRowAtIndexPath?(indexPath: indexPath) ?? true
  }
  
  public var canPerformActionForRowAtIndexPathWithSender:((action:Selector, indexPath:NSIndexPath, sender:AnyObject?) -> Bool)?
  public func tableView(tableView: UITableView, canPerformAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
    return canPerformActionForRowAtIndexPathWithSender?(action: action, indexPath: indexPath, sender: sender) ?? false
  }
  
  public var didDeselectRowAtIndexPath:((indexPath:NSIndexPath) -> Void)?
  public func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    didDeselectRowAtIndexPath?(indexPath:indexPath)
  }
  
  public var didEndDisplayingCellForRowAtIndexPath:((cell:UITableViewCell, indexPath:NSIndexPath) -> Void)?
  public func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    didEndDisplayingCellForRowAtIndexPath?(cell: cell, indexPath: indexPath)
  }
  
  public var didEndDisplayingFooterViewForSection:((view:UIView, section:Int) -> Void)?
  public func tableView(tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
    didEndDisplayingFooterViewForSection?(view:view, section:section)
  }
  
  public var didEndDisplayingHeaderViewForSection:((view:UIView, section:Int) -> Void)?
  public func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
    didEndDisplayingHeaderViewForSection?(view: view, section: section)
  }
  
  public var didEndEditingRowAtIndexPath:((indexPath:NSIndexPath) -> Void)?
  public func tableView(tableView: UITableView, didEndEditingRowAtIndexPath indexPath: NSIndexPath) {
    didEndEditingRowAtIndexPath?(indexPath: indexPath)
  }
  
  public var didHighlightRowAtIndexPath:((indexPath:NSIndexPath) -> Void)?
  public func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
    didHighlightRowAtIndexPath?(indexPath: indexPath)
  }
  
  public var didUnhighlightRowAtIndexPath:((indexPath:NSIndexPath) -> Void)?
  public func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
    didUnhighlightRowAtIndexPath?(indexPath: indexPath)
  }
  
  public var editActionsForRowAtIndexPath:((indexPath:NSIndexPath) -> [UITableViewRowAction]?)?
  public func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
    return editActionsForRowAtIndexPath?(indexPath: indexPath) ?? nil
  }
  
  public var editingStyleForRowAtIndexPath:((indexPath:NSIndexPath) -> UITableViewCellEditingStyle)?
  public func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
    return editingStyleForRowAtIndexPath?(indexPath: indexPath) ?? UITableViewCellEditingStyle.None
  }
  
  public var estimatedHeightForFooterInSection:((section:Int) -> CGFloat)?
  public func tableView(tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
    return estimatedHeightForFooterInSection?(section: section) ?? estimatedSectionFooterHeight
  }
  
  //EXPL: commented out because these functions were causing display bugs.
  //
  //  public var estimatedHeightForHeaderInSection:((section:Int) -> CGFloat)?
  //  public func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
  //    return estimatedHeightForHeaderInSection?(section: section) ?? estimatedSectionHeaderHeight
  //  }
  //
  //  public var estimatedHeightForRowAtIndexPath:((indexPath:NSIndexPath) -> CGFloat)?
  //  public func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
  //    return estimatedHeightForRowAtIndexPath?(indexPath: indexPath) ?? estimatedRowHeight
  //  }
  //
  public var heightForFooterInSection:((section:Int) -> CGFloat)?
  public func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return heightForFooterInSection?(section:section) ?? estimatedSectionFooterHeight
  }
  
  public var heightForHeaderInSection:((section:Int) -> CGFloat)?
  public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return heightForHeaderInSection?(section:section) ?? estimatedSectionHeaderHeight
  }
  
  //  //HACK: implementing this function apparently results in performance penalties...should look for a work-around.
  //  public var heightForRowAtIndexPath:((indexPath:NSIndexPath) -> CGFloat)?
  //  public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
  //    return heightForRowAtIndexPath?(indexPath: indexPath) ?? self.rowHeight
  //  }
  
  public var indentationLevelForRowAtIndexPath:((indexPath:NSIndexPath) -> Int)?
  public func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
    return indentationLevelForRowAtIndexPath?(indexPath: indexPath) ?? 0
  }
  
  public var moveRowAtIndexPathToIndexPath:((sourceIndexPath:NSIndexPath, destinationIndexPath:NSIndexPath) -> Void)?
  public func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
    moveRowAtIndexPathToIndexPath?(sourceIndexPath: sourceIndexPath, destinationIndexPath: destinationIndexPath)
  }
  
  public var performActionForRowAtIndexPathWithSender:((action:Selector, indexPath:NSIndexPath, sender:AnyObject!) -> Void)?
  public func tableView(tableView: UITableView, performAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    performActionForRowAtIndexPathWithSender?(action: action, indexPath: indexPath, sender: sender)
  }
  
  public var sectionForSectionIndexTitleAtIndex:((title:String, index:Int) -> Int)?
  public func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
    return sectionForSectionIndexTitleAtIndex?(title: title, index: index) ?? 0
  }
  
  public var shouldHighlightRowAtIndexPath:((indexPath:NSIndexPath) -> Bool)?
  public func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return shouldHighlightRowAtIndexPath?(indexPath: indexPath) ?? true
  }
  
  public var shouldIndentWhileEditingRowAtIndexPath:((indexPath:NSIndexPath) -> Bool)?
  public func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return shouldIndentWhileEditingRowAtIndexPath?(indexPath: indexPath) ?? true
  }
  
  public var shouldShowMenuForRowAtIndexPath:((indexPath:NSIndexPath) -> Bool)?
  public func tableView(tableView: UITableView, shouldShowMenuForRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return shouldShowMenuForRowAtIndexPath?(indexPath: indexPath) ?? false
  }
  
  public var targetIndexPathForMoveFromRowAtIndexPathToProposedIndexPath:((sourceIndexPath:NSIndexPath, proposedDestinationIndexPath:NSIndexPath) -> NSIndexPath)?
  public func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
    return targetIndexPathForMoveFromRowAtIndexPathToProposedIndexPath?(sourceIndexPath: sourceIndexPath, proposedDestinationIndexPath: proposedDestinationIndexPath) ?? proposedDestinationIndexPath
  }
  
  public var titleForDeleteConfirmationButtonForRowAtIndexPath:((indexPath:NSIndexPath) -> String?)?
  public func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
    return titleForDeleteConfirmationButtonForRowAtIndexPath?(indexPath: indexPath)
  }
  
  public var titleForFooterInSection:((section:Int) -> String?)?
  public func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return titleForFooterInSection?(section:section) ?? nil
  }
  
  public var willBeginEditingRowAtIndexPath:((indexPath:NSIndexPath) -> Void)?
  public func tableView(tableView: UITableView, willBeginEditingRowAtIndexPath indexPath: NSIndexPath) {
    willBeginEditingRowAtIndexPath?(indexPath: indexPath)
  }
  
  public var willDeselectRowAtIndexPath:((indexPath:NSIndexPath) -> NSIndexPath?)?
  public func tableView(tableView: UITableView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    return willDeselectRowAtIndexPath?(indexPath: indexPath) ?? indexPath
  }
  
  public var willDisplayCellForRowAtIndexPath:((cell:UITableViewCell, indexPath:NSIndexPath) -> Void)?
  public func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    willDisplayCellForRowAtIndexPath?(cell: cell, indexPath: indexPath)
  }
  
  public var willDisplayFooterViewForSection:((view:UIView, section:Int) -> Void)?
  public func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
    willDisplayFooterViewForSection?(view:view, section:section)
  }
  
  public var willDisplayHeaderViewForSection:((view:UIView, section:Int) -> Void)?
  public func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    willDisplayHeaderViewForSection?(view: view, section: section)
  }
  
  public var willSelectRowAtIndexPath:((indexPath:NSIndexPath) -> NSIndexPath)?
  public func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    return willSelectRowAtIndexPath?(indexPath: indexPath) ?? indexPath
  }
}