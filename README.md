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
    private var _text = BindableValue<String>(initialValue:"Hello")

    @IBOutlet weak var textField:BindableTextField! //NOTE: tied to a storyboard element of type BindableTextField.

    override public viewDidLoad(){
        super.viewDidLoad()

        textField.bindableValue = _text //EFFECT: textField's text is now set to "Hello"

        _text = "Test" //EFFECT textField's teext is now "Test"
    }
}
```

### BindableTextView
This works almost identically to the BindableTextField

```
import AwfulBinding
import AwfulBindingUI

public class SomeViewController:UIViewController{
    private var _text = BindableValue<String>(initialValue:"Hello")

    @IBOutlet weak var textView:BindableTextView! //NOTE: tied to a storyboard element of type BindableTextView.

    override public viewDidLoad(){
        super.viewDidLoad()

        textView.bindableValue = _text //EFFECT: textView's text is now set to "Hello"

        _text = "Test" //EFFECT textField's teext is now "Test"
    }
}
```

### BindableImageView

```
import AwfulBinding
import AwfulBindingUI

public class SomeViewController:UIViewController{
    private var _text = BindableValue<String>(initialValue:"Hello")

    @IBOutlet weak var textView:BindableTextView! //NOTE: tied to a storyboard element of type BindableTextView.

    override public viewDidLoad(){
        super.viewDidLoad()

        textView.bindableValue = _text //EFFECT: textView's text is now set to "Hello"

        _text = "Test" //EFFECT textField's teext is now "Test"
    }
}
```

### BindableTableView
NOTE: BindableTableView doesn't currently support sectioned data (i.e. the section count is hardcoded to 1)...this is planned for later.

```
import AwfulBinding
import AwfulBindingUI

public class SomeViewController:UIViewController{
    private var _data = BindableArray<String>(initialValue:["Item 1", "Item 2", "Item 3"])

    @IBOutlet weak var tableView:BindableTableView! //NOTE: tied to a storyboard element of type BindableTableView

    override public viewDidLoad(){
        super.viewDidLoad()

        tableView.cellForRowAtIndexPath = cellCreator
        tableView.bindableArray = _data
    }

    private func cellCreator(indexPath:NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueCellForIdentifier("SomeCellIdentifier", indexPath:indexPath)

        let dataElement = _data[indexPath.row]

        cell.textLabel.text = dataElement

        return cell
    }
}
```

### BindableCollectionView

```
TODO
```

### BindableButton

```
TODO
```