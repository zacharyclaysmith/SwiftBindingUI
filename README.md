# AwfulBindingUI
A library of simple UI components built around the AwfulBinding library.

## Installation

1. Carthage
* Add `github "zacharyclaysmith/AwfulBindingUI"` to your Cartfile
* Run `carthage update`
2. CocoaPods
*Not yet supported*
3. Manual Installation
Just pull down the repo and build it, then include the framework in your project.

## Usage

### BindableTextField

```
import AwfulBinding
import AwfulBindingUI

public class SomeViewController:UIViewController{
    private var _someBindableText = BindableValue<String>(initialValue:"Hello")

    @IBOutlet weak var bindableTextField:BindableTextField! //NOTE: tied to a storyboard element of type BindableTextField.

    override public viewDidLoad(){
        super.viewDidLoad()

        bindableTextField.bindableValue = _someBindableText //EFFECT: bindableTextField's text field is now set to "Hello" and will update whenever _someBindableText's value is changed.
    }
}
```

### BindableTextView

```
TODO
```

### BindableImageView

```
TODO
```

### BindableTableView

```
TODO
```

### BindableCollectionView

```
TODO
```

### BindableButton

```
TODO
```