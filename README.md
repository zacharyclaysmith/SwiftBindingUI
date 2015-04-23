# SwiftBindingUI
A library of simple UI components built around the SwiftBinding library.

## Installation

1. Carthage
  * Add `github "zacharyclaysmith/SwiftBindingUI"` to your Cartfile
  * Run `carthage update`
2. CocoaPods
  * pod 'SwiftBindingUI'
3. Manual Installation
  * Just pull down the repo and build it, then include the framework in your project.

## Goals/Philosophy
Generally, as a long-time MVC (aka MVVM, MV*, etc.) advocate, Apple's delegate pattern hurts my heart (and my sanity). Here's a brief summary on why I started this framework and goals I try to work towards when modifying it:

1. Reactive UI beats Imperative UI
  * I want my elements to decide what to do based on their data...manually grabbing UI elements and modifying them is effective but not at all sustainable.
2. Ease the inconsistencies between base UIKit elements.
  * Apple's built in UI elements are ridiculously inconsistent...Compare BindableTextField and BindableTextView's implementations to get a good idea.

## Usage

### BindableTextField
Generally known as the king of any binding framework, I've tried to make this guy as simple to use as possible.

Bindable Properties:
  * textBinding: a `BindableValue<String>` that is 2-way bound to the `text` property.
  * hiddenBinding: a `BindableValue<Bool>` that is bound to the `hidden` property.

```
import SwiftBinding
import SwiftBindingUI

public class SomeViewController:UIViewController{
    private let _text = BindableValue(value:"Hello")

    @IBOutlet weak var textField:BindableTextField! //NOTE: This is tied to a storyboard/xib element of type BindableTextField.

    override public viewDidLoad(){
        super.viewDidLoad()

        textField.textBinding = _text //EFFECT: textField's text is now set to "Hello"

        _text.value = "Test" //EFFECT textField's text is now "Test"

        //UI EFFECT: changes to the textField in the UI will update the value of _text
    }
}
```

### BindableTextView
This works almost identically to the BindableTextField.

Bindable Properties:
  * textBinding: a `BindableValue<String>` that is 2-way bound to the `text` property.
  * hiddenBinding: a `BindableValue<Bool>` that is bound to the `hidden` property.

```
import SwiftBinding
import SwiftBindingUI

public class SomeViewController:UIViewController{
    private var _text = BindableValue(value:"Hello")

    @IBOutlet weak var textView:BindableTextView! //NOTE: tied to a storyboard element of type BindableTextView.

    override public viewDidLoad(){
        super.viewDidLoad()

        textField.textBinding = _text //EFFECT: textField's text is now set to "Hello"

        _text.value = "Test" //EFFECT textField's text is now "Test"

        //UI EFFECT: changes to the textField in the UI will update the value of _text
    }
}
```

### BindableImageView

Bindable Properties:
  * imageBinding: a `BindableValue<UIImage?>` that is bound to the `image` property.
  * hiddenBinding: a `BindableValue<Bool>` that is bound to the `hidden` property.

Other Properties:
  * nilImage: an optional `UIImage?` that is used whenever the value property of `imageBinding` is nil.

### BindableLabel

Bindable Properties:
  * textBinding: a `BindableValue<String>` that is bound to the `text` property.
  * hiddenBinding: a `BindableValue<Bool>` that is bound to the `hidden` property.

### BindableView

Bindable Properties:
  * hiddenBinding: a `BindableValue<Bool>` that is bound to the `hidden` property.

### BindableSwitch

Bindable Properties:
  * onBinding: a `BindableValue<Bool>` that is 2-way bound to the `on` property.
  * hiddenBinding: a `BindableValue<Bool>` that is bound to the `hidden` property.

### BindableButton

Bindable Properties:
  * `enabledBinding:BindableValue<Bool>` - 2-way bound to the `enabled` property.
  * `hiddenBinding:BindableValue<Bool>` - bound to the `hidden` property.
  * `textBinding:`BindableValue<String>` - bound to the title of the button (uses the recommended `setTitle` method). NOTE: At this time, this only applies to the "Normal" state, but will be expanded as the demand arises.
  * `imageBinding:BindableValue<UIImage?>` - bound to the image of the button (uses the recommended `setImage` method). NOTE: At this time, this only applies to the "Normal" state, but will be expanded as the demand arises.

### BindableSearchBar
Note that this implements its own UISearchBarDelegate, and overwriting the delegate property will break some aspects of its behavior.

Bindable Properties:
  * `textBinding: BindableValue<String>`
  * `hiddenBinding:BindableValue<Bool>` - bound to the `hidden` property.

Other Properties:
  * `onBeginEditing: (() -> Void)?`
  * `onEndEditing: (() -> Void)?`
  * `onSearchButtonClick: (() -> Void)?`
  * `onCancelButtonClick: (() -> Void)?`

### BindableTableView
Note that this implements itself as its own `UITableViewDataSource` and `UITableViewDelegate`, and overwriting the `datasource` or `delegate` property will break some (most) aspects of its behavior.

TODO: very much a work in progress
TODO: more documentation and examples

Bindable Properties:
  * `sections: BindableArray<PBindableTableSection>` - This is a collection of table sections.
  * `singleSection:PBindableTableSection` - This is a convenience property that exposes the `sections` property as if it were a single section. I find I use this most often, as my tables are rarely sectioned in practice.
  * `hiddenBinding:BindableValue<Bool>` - bound to the `hidden` property.

Other Properties:
  * `reloadOnSelect:Bool`
  * `onSelect:((section:PBindableTableSection, index:Int) -> Void)?`
  * `defaultCellCreator:((sectionIndex:Int, index:Int) -> UITableViewCell)`
  * `viewForHeaderInSection:((sectionIndex:Int) -> UIView)?`
  * `viewForFooterInSection:((sectionIndex:Int) -> UIView)?`
  * `deleteHandler:((indexPath:NSIndexPath) -> Void)?`

### BindableCollectionView
Note that this implements itself as its own `UICollectionViewDataSource` and `UICollectionViewDelegate`, and overwriting the `datasource` or `delegate` property will break some (most) aspects of its behavior.

TODO: very much a work in progress
TODO: more documentation and examples

Bindable Properties:
  * `sections: BindableArray<PBindableTableSection>` - This is a collection of table sections.
  * `singleSection:PBindableTableSection` - This is a convenience property that exposes the `sections` property as if it were a single section. I find I use this most often, as my tables are rarely sectioned in practice.
  * `hiddenBinding:BindableValue<Bool>` - bound to the `hidden` property.
  * `showFooterBinding:BindableValue<Bool>`

Other Properties:
  * `reloadOnSelect:Bool`
  * `onSelect:((section:PBindableTableSection, index:Int) -> Void)?`
  * `defaultCellCreator:((sectionIndex:Int, index:Int) -> UITableViewCell)`
  * `viewForHeaderInSection:((sectionIndex:Int) -> UIView)?`
  * `viewForFooterInSection:((sectionIndex:Int) -> UIView)?`
  * `deleteHandler:((indexPath:NSIndexPath) -> Void)?`
