import Foundation
import UIKit
import AwfulBinding

public class BindableLabel:UILabel{
    private var _bindableValue:BindableValue<String>?
    
    public var bindableValue:BindableValue<String>?{
        get{
            return _bindableValue
        }
        
        set(newValue){
            _bindableValue = newValue
            
            _bindableValue?.addListener(self, listener:valueChanged, alertNow: true)
        }
    }
    
    private func valueChanged(newValue:String?){
        self.text = newValue
    }
}