import Foundation
import UIKit
import AwfulBinding

public class BindableLabel:UILabel{
    private var _bindableValue:BindableValue<Any>?
    
    public var bindableValue:BindableValue<Any>?{
        get{
            return _bindableValue
        }
        
        set(newValue){
            _bindableValue?.removeListener(self)
            
            _bindableValue = newValue
            
            _bindableValue?.addListener(self, listener:valueChanged, alertNow: true)
        }
    }
    
    private func valueChanged(newValue:Any){
        self.text = toString(newValue)
    }
    
    deinit{
        _bindableValue?.removeListener(self)
        _hiddenBinding?.removeListener(self)
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