import UIKit

@IBDesignable class DesignableView: UIView
{
    // You can configure outlets using the File's Owner in the xib
    @IBOutlet weak var label: UILabel!
    
    // Setting an outlet to the root view in the xib file means you don't have to find the view in the setup() method below
    @IBOutlet var contentView: UIView!
    
    // You can optionally use IBInspectable properties
    // and even see the results on the storyboard
    @IBInspectable var labelText: String = "" {
        didSet {
            label.text = labelText
        }
    }
    
    
    //MARK: init
    
    // This is required for the IBDesignable to work
    override init(frame: CGRect)
    {
        super.init(frame:frame)
        setup()
    }

    // This is required at runtime
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder:aDecoder)
        setup()
    }
    
    
    
    // This is where the magic happens
    // We instantiate a view 
    // (not a DesignableView class, but a regular UIView ... see the xib)
    // The oulets and actions get sent to the File's Owner (this DesignableView instance)
    // The frame is all that is needed, autolayout does the rest
    func setup()
    {
        UINib(nibName:"DesignableView", bundle:NSBundle(forClass:self.dynamicType)).instantiateWithOwner(self, options:nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = true
        addSubview(contentView)
    }
    
}
