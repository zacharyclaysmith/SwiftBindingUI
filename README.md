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
public class SomeViewController:UIViewController{
    private var _someBindableText = BindableValue<String>(initialValue:"")

    @IBOutlet weak var bindableTextField:

    override public viewDidLoad(){
        super.viewDidLoad()

        bindableTextField.bindableValue = _someBindableText
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