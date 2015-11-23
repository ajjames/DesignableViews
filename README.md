# DesignableViews
This project demonstrates how to easily embed a designable xib in a storyboard

Often in iOS development, we find the need to create a view that needs to be reused in multiple view controllers. The problem with this in the past is that we end up with storyboards that have seemingly blank views that are not as easy to follow.

Enter `@IBDesignable`. We can do a lot with this flag with little effort.

Here it is using Swift 2.

### A DesignableView class ###
`@IBDesignable class DesignableView : UIView`

By combining `@IBDesignable` with a little bit of glue code, we can create interactive interface builder views that can be reused in storyboard scenes as well as other xibs.

The following initializer is required so that the view renders properly for `@IBDesignable`:
```
override init(frame: CGRect)
{
    super.init(frame:frame)
    setup()
}
```

Another initializer is required at runtime when the instance is created from the interface builder file:
```
required init?(coder aDecoder: NSCoder)
{
    super.init(coder:aDecoder)
    setup()
}
```

`setup()` is where the magic happens. This is not a new technique, but its simplified by creating an outlet for the root view in the xib file to a `contentView` property on `file's owner`.

If you look in the xib, the root view is of type `UIView` (not `DesignableView` like most UIView subclasses that use a xib). `DesignableView` is the `file's owner` of the xib. The outlets and actions are connected directly to `file's owner` (`DesignableView`).

Finally, the frame is all that is needed before adding `contentView` as a subview of `DesignableView.view`. Auto layout does the rest:
```
@IBOutlet var contentView: UIView!

func setup()
{
    UINib(nibName:"DesignableView", bundle:NSBundle(forClass:self.dynamicType)).instantiateWithOwner(self, options:nil)
    contentView.frame = bounds
    contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    contentView.translatesAutoresizingMaskIntoConstraints = true
    addSubview(contentView)
}
```

This code project shows only the minimum code needed to demonstrate how it works.

`DesignableView` could easily be abstracted as a superclass if desired. (replace the hard-coded `"DesignableView"` with `NSStringFromClass(self.dynamicType).componentsSeparatedByString(".").last!`)

Enjoy!
