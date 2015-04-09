import Foundation
import UIKit
import AwfulBinding

public class BindableLabel:UILabel, PTextBindable, PHiddenBindable{
    private var _textBinding:BindableValue<String>?
    
    //DEPRECATED
    public var bindableValue:BindableValue<String>?{
        get{
            return _textBinding
        }
        
        set(newValue){
            _textBinding?.removeListener(self)
            
            _textBinding = newValue
            
            _textBinding?.addListener(self, alertNow: true, listener:valueChanged)
        }
    }
    
    public var textBinding:BindableValue<String>?{
        get{
            return _textBinding
        }
        
        set(newValue){
            _textBinding?.removeListener(self)
            
            _textBinding = newValue
            
            _textBinding?.addListener(self, alertNow: true, listener:valueChanged)
        }
    }
    
    private func valueChanged(newValue:String){
        self.text = newValue
    }
    
    deinit{
        _textBinding?.removeListener(self)
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
            
            _hiddenBinding?.addListener(self, alertNow: true, listener:hiddenBinding_valueChanged)
        }
    }
    private func hiddenBinding_valueChanged(newValue:Bool){
        self.hidden = newValue
    }
}